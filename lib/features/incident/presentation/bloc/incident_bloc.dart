import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/errors/custom_error.dart';
import 'package:micropolis_test/core/results/result.dart';
import 'package:micropolis_test/features/incident/data/datasource/incidents_remotedatasource.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_classification_model.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';

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
    } else if (event is GetIncidentClassification) {
      final remote = await IncidentsRemoteDataSource()
          .getIncidentsClassification(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, IncidentsClassificationModel>)
                .value);

        yield GetIncidentsClassificationSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, IncidentsClassificationModel>)
                .value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetSubjects) {
      final remote = await IncidentsRemoteDataSource().getSubjects(event.param);
      if (remote.isRight()) {
        var result =
            Result(data: (remote as Right<BaseError, SubjectsModel>).value);
        yield GetSubjectsSuccessState(result.data);
      } else {
        var error =
            Result(error: (remote as Left<BaseError, SubjectsModel>).value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is GetSingleIncident) {
      yield GetIncidentsWaitingState();

      final remote =
          await IncidentsRemoteDataSource().getSingleIncident(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, SingleIncidentModel>).value);
        yield GetSingleIncidentSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, SingleIncidentModel>).value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    } else if (event is UpgradeIncident) {
      yield GetIncidentsWaitingState();

      final remote =
          await IncidentsRemoteDataSource().upgradeIncident(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, UpdatedIncidentModel>).value);
        yield UpgradeIncidentSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, UpdatedIncidentModel>).value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
    else if (event is DeleteIncident) {
      yield GetIncidentsWaitingState();

      final remote =
      await IncidentsRemoteDataSource().deleteIncident(event.param);
      if (remote.isRight()) {
        var result = Result(
            data: (remote as Right<BaseError, UpdatedIncidentModel>).value);
        yield DeleteIncidentSuccessState(result.data);
      } else {
        var error = Result(
            error: (remote as Left<BaseError, UpdatedIncidentModel>).value);
        yield GetIncidentFailureState(
            error: error.error,
            callback: () {
              this.add(event);
            });
      }
    }
  }
}
