import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/map/data/models/authority_area_model.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/police_department_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';
import 'package:micropolis_test/features/map/data/models/region_model.dart';
import 'package:micropolis_test/features/map/data/models/region_type_model.dart';
import 'package:micropolis_test/features/map/data/models/sensitive_location_model.dart';
import 'package:micropolis_test/features/map/data/params/add_authority_param.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';

class PolygonRemoteDataSource extends RemoteDataSource {

  Future<Either<BaseError, SensitiveLocationModel>> createSensitiveLocation(
      AddSensitiveLocationParam params) {
    print(params.toMap());
    return request(
        converter: (json) => SensitiveLocationModel.fromMap(json),
        method: HttpMethod.POST,
        dataString: params.toJson(),
        url: API_GET_SENSITIVE_LOCATION,
        baseURL: "http://94.206.14.42:5000/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, PolygonsModel>> getPolygons(NoParams params) {
    return request(
        converter: (json) => PolygonsModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_CREATE_POLYGON,
        baseURL: "http://94.206.14.42:5000/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, RegionModel>> getRegions(NoParams params) {
    return request(
        converter: (json) => RegionModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_REGIONS,
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, RegionTypeModel>> getRegionTypes(NoParams params) {
    return request(
        converter: (json) => RegionTypeModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_REGION_TYPES,
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, PoliceDepartmentModel>> getPoliceDepartments(
      NoParams params) {
    return request(
        converter: (json) => PoliceDepartmentModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_POLICE_DEPARTMENT,
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, AuthorityAreaModel>> getAuthorityAreas(
      NoParams params) {
    return request(
        converter: (json) => AuthorityAreaModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_AUTHORITY_AREAS,
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, AuthorityAreaModel>> createAuthorityArea(
      AddAuthorityParam params) {
    print(params.toJson());
    return request(
        converter: (json) => AuthorityAreaModel.fromMap(json),
        method: HttpMethod.POST,
        url: API_GET_AUTHORITY_AREAS,
        dataString: params.toJson(),
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, GetSensitiveLocationModel>> getSensitiveLocations(
      NoParams params) {
    return request(
        converter: (json) => GetSensitiveLocationModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_SENSITIVE_LOCATION,
        isList:  true,
        cancelToken: params.cancelToken);
  }
}