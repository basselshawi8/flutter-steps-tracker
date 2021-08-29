import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_classification_model.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/model/subject_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';
import 'package:micropolis_test/features/incident/data/params/single_incident_param.dart';
import 'package:micropolis_test/features/incident/data/params/subject_param.dart';
import 'package:micropolis_test/features/incident/data/params/update_incident_param.dart';

class IncidentsRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, IncidentsModel>> getIncidents(
      IncidentsParam params) {
    return request(
        converter: (json) => IncidentsModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_INCIDENT,
        queryParameters: params.toMap(),
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, SingleIncidentModel>> getSingleIncident(
      SingleIncidentParam params) {
    return request(
        converter: (json) => SingleIncidentModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_GET_INCIDENT/${params.id}",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, UpdatedIncidentModel>> upgradeIncident(
      UpdateIncidentParam params) {
    return request(
        converter: (json) => UpdatedIncidentModel.fromMap(json),
        method: HttpMethod.PUT,
        url: "$API_GET_INCIDENT/${params.id}",
        data: params.toMap(),
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, UpdatedIncidentModel>> deleteIncident(
      SingleIncidentParam params) {
    return request(
        converter: (json) => UpdatedIncidentModel.fromMap(json),
        method: HttpMethod.DELETE,
        url: "$API_GET_INCIDENT/${params.id}",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, IncidentsClassificationModel>>
      getIncidentsClassification(NoParams params) {
    return request(
        converter: (json) => IncidentsClassificationModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_INCIDENT_CLASSIFICATION,
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, SubjectsModel>> getSubjects(SubjectsParam params) {
    return request(
        converter: (json) => SubjectsModel.fromMap(json),
        method: HttpMethod.POST,
        url: API_GET_SUBJECTS,
        data: params.toMap(),
        baseURL: "https://subjectapi.herokuapp.com/",
        cancelToken: params.cancelToken);
  }
}
