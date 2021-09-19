import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/map/data/models/create_polygon_model.dart';
import 'package:micropolis_test/features/map/data/models/polygons_model.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';

class PolygonRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, CreatePolygonModel>> createPolygon(
      AddPolygonParam params) {
    print(params.toMap());
    return request(
        converter: (json) => CreatePolygonModel.fromMap(json),
        method: HttpMethod.POST,
        data: params.toMap(),
        url: API_CREATE_POLYGON,
        baseURL: "http://212.114.52.13:5003/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, PolygonsModel>> getPolygons(NoParams params) {
    return request(
        converter: (json) => PolygonsModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_CREATE_POLYGON,
        baseURL: "http://212.114.52.13:5003/",
        cancelToken: params.cancelToken);
  }
}
