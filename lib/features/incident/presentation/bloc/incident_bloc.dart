import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/features/camera/domain/repository/iIncidents_repository.dart';
import 'package:micropolis_test/features/camera/domain/usecase/get_incident_usecase.dart';

import './bloc.dart';
import '../../../../service_locator.dart';

class IncidentsBloc extends Bloc<IncidentsEvent, IncidentState> {
  IncidentsBloc() : super(InitialIncidentState());

  @override
  Stream<IncidentState> mapEventToState(IncidentsEvent event) async* {
    if (event is GetIncident) {
      yield GetIncidentWaitingState();
      final result = await GetIncidentUseCase(locator<IIncidentsRepository>())
          .call(event.param);
      if (result.hasDataOnly) {
        yield GetIncidentSuccessState(result.data);
      } else if (result.hasErrorOnly) {
        yield GetIncidentFailureState(
            error: result.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
