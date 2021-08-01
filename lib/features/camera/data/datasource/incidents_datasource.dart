import 'package:dartz/dartz.dart';

import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';

import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/camera/data/model/incident_model.dart';
import 'package:micropolis_test/features/camera/data/params/incident_param.dart';
import 'package:micropolis_test/features/restaurants/data/model/menu_model.dart';

import 'package:micropolis_test/features/restaurants/data/model/restaurant_model.dart';
import 'package:micropolis_test/features/restaurants/data/params/get_menu_param.dart';

import 'iIncidents_datasource.dart';

class IncidentsRemoteDataSource extends IIncidentsRemoteDataSource {
  @override
  Future<Either<BaseError, IncidentModel>> getIncidentById(
      IncidentParam params) {
    return request(
        converter: (json) => IncidentModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_GET_INCIDENT/${params.incidentID}",
        cancelToken: params.cancelToken);
  }
}
