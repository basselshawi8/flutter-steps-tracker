import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';
import 'package:micropolis_test/features/incident/data/model/incidents_model.dart';
import 'package:micropolis_test/features/incident/data/params/incidents_param.dart';

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
}
