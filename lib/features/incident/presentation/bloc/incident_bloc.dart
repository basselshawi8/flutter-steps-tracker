import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/incident/data/datasource/incidents_remotedatasource.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';

import './bloc.dart';

class IncidentsListBloc extends Bloc<IncidentsEvent, IncidentsState> {
  IncidentsListBloc() : super(InitialIncidentsState());

  @override
  Stream<IncidentsState> mapEventToState(IncidentsEvent event) async* {
    if (event is GetIncidents) {
      yield GetIncidentsWaitingState();

      final remote =
          await IncidentsRemoteDataSource().getIncidents(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, IncidentsModel>).value);
        yield GetIncidentsSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, IncidentsModel>).value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
