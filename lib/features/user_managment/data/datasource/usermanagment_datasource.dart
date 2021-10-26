import 'package:dartz/dartz.dart';
import 'package:micropolis_test/core/datasources/remote_data_source.dart';
import 'package:micropolis_test/core/errors/base_error.dart';
import 'package:micropolis_test/core/http/api_url.dart';
import 'package:micropolis_test/core/http/http_method.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_behavioral_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_human_detection_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_user_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_behavioral_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_facial_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/get_human_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/role_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/users_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/vechile_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_behavioral_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_facial_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_human_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_user_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/get_vehicle_attr_param.dart';

class UserManagementRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, CreateUserModel>> createUser(
      CreateUserParam params) {
    return request(
        converter: (json) => CreateUserModel.fromMap(json),
        method: HttpMethod.POST,
        data: params.toMap(),
        url: API_CREATE_USER,
        baseURL: "http://localhost:5002/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, UsersListModel>> getUsers(NoParams params) {
    return request(
        converter: (json) => UsersListModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_CREATE_USER,
        baseURL: "http://localhost:5002/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, RoleListModel>> getRoles(NoParams params) {
    return request(
        converter: (json) => RoleListModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_ROLE,
        baseURL: "http://localhost:5002/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, VehicleListModel>> getVehicles(NoParams params) {
    return request(
        converter: (json) => VehicleListModel.fromMap(json),
        method: HttpMethod.GET,
        url: API_GET_VEHICLE,
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, CreateBehavioralModel>> createBehavioral(
      CreateBehavioralParam params) {
    return request(
        converter: (json) => CreateBehavioralModel.fromMap(json),
        method: HttpMethod.POST,
        data: params.toMap(),
        url: "$API_GET_BEHAVIORAL/${params.vehicle_id}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, CreateFacialModel>> createFacial(
      CreateFacialParam params) {
    print(params.toMap());
    return request(
        converter: (json) => CreateFacialModel.fromMap(json),
        method: HttpMethod.POST,
        data: params.toMap(),
        url: "$API_GET_FACIAL/${params.vehicle_id}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, CreateHumanDetectionModel>> createHumanDetection(
      CreateHumanDetectionParam params) {
    return request(
        converter: (json) => CreateHumanDetectionModel.fromMap(json),
        method: HttpMethod.POST,
        data: params.toMap(),
        url: "$API_GET_HUMAN_DETECTION/${params.vechileID}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, GetFacialRecognitionModel>> getFacialRecognition(
      GetVechileParam params) {
    return request(
        converter: (json) => GetFacialRecognitionModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_GET_FACIAL/${params.vechileID}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, GetBehavioralAnalysisModel>> getBehavioralAnalysis(
      GetVechileParam params) {
    return request(
        converter: (json) => GetBehavioralAnalysisModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_GET_BEHAVIORAL/${params.vechileID}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }

  Future<Either<BaseError, GetHumanDetectionModel>> getHumanDetection(
      GetVechileParam params) {
    return request(
        converter: (json) => GetHumanDetectionModel.fromMap(json),
        method: HttpMethod.GET,
        url: "$API_GET_HUMAN_DETECTION/${params.vechileID}",
        baseURL: "http://localhost:5004/",
        cancelToken: params.cancelToken);
  }
}
