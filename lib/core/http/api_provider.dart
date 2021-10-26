import 'dart:io';

import 'package:micropolis_test/core/errors/custom_error.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:micropolis_test/core/models/bad_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';
import 'api_url.dart';
import 'http_method.dart';
import 'models_factory.dart';

class ApiProvider {
  // Singleton handling.
  static ApiProvider _instance;

  static ApiProvider getInstance() {
    if (_instance != null) return _instance;
    _instance = ApiProvider();
    return _instance;
  }

  final option = BaseOptions(
    baseUrl: API_OPERATION_BASE,
    connectTimeout: 20000,
  );
  Dio _dio;

  Future<Either<BaseError, T>> sendRequest<T extends BaseModel>({
    @required HttpMethod method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, dynamic> headers,
    String baseURL,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  }) async {
    assert(method != null);
    assert(url != null);
    if (baseURL != null) {
      _dio = Dio(BaseOptions(
        baseUrl: baseURL,
        connectTimeout: 20000,
      ));
    } else {
      _dio = Dio(option);
    }
    if (_dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    try {
      print('[$method: $url,$queryParameters]');
      Response response;
      switch (method) {
        case HttpMethod.GET:
          // Get the response from the server
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _dio.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(
              headers: headers,
            ),
            cancelToken: cancelToken,
          );
          print(response.data.toString());
          break;
        case HttpMethod.PUT:
          response = await _dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      // Get the decoded json
      /// json response like this
      /// {"data":"our data",
      /// "succeed":true of false,
      /// "message":"message if there is error"}
      /// response.data["succeed"] return true if request
      /// succeed and false if not so if was true we don't need
      /// return this value to model we just need the data
      print(response.data);
      var model;
      if (response.data != null) {
        // Here we send the data from response to Models factory
        // to assign data as model
        if (response.data is List) {
          try {
            model = ModelsFactory.getInstance().createModel<T>(response.data);
          } catch (e) {
            print(e);
            return Left(CustomError(message: e.toString()));
          }
          return Right(model);
        } else {
          try {
            model = ModelsFactory.getInstance().createModel<T>(response.data);
          } catch (e, stack) {
            print(stack);
            print(e);
            return Left(CustomError(message: e.toString()));
          }
          return Right(model);
        }
      } else if (!response.data["succeed"]) {
        return Left(CustomError(message: response.data["message"]));
      } else
        return Left(CustomError(message: "Null Json response in api provider"));
    }

    // Handling errors
    on DioError catch (e) {
      print(e.message);
      return Left(_handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(SocketError());
    }
  }

  Future<Either<BaseError, T>> upload<T extends BaseModel>({
    @required String url,
    @required String fileKey,
    @required String filePath,
    @required String fileName,
    Map<String, dynamic> data,
    Map<String, String> headers,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    CancelToken cancelToken,
  }) async {
    assert(url != null);
    assert(fileKey != null);

    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    if (filePath != null && fileName != null) {
      dataMap.addAll({
        fileKey: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType("image", "jpeg"),
        )
      });
    }
    try {
      final response = await _dio.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      var model;
      // Get the decoded json
      if (response.data["succeed"]) {
        // Here we send the data from response to Models factory
        // to assign data as model
        if (response.data["data"] == null) {
          try {
            model = ModelsFactory.getInstance().createModel<T>(response.data);
          } catch (e) {
            print(e);
            return Left(CustomError(message: e.toString()));
          }
          return Right(model);
        } else {
          try {
            model = ModelsFactory.getInstance().createModel<T>(response.data);
          } catch (e, stack) {
            print(stack);
            print(e);
            return Left(CustomError(message: e.toString()));
          }
          return Right(model);
        }
      } else if (!response.data["succeed"]) {
        return Left(CustomError(message: response.data["message"]));
      } else
        return Left(CustomError(message: "Null Json response in api provider"));
    } // Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(SocketError());
    }
  }

  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error.error is SocketException)
        return SocketError();
      else if (error.type == DioErrorType.response) {
        switch (error.response.statusCode) {
          case 400:
            if (error.response?.data == null)
              return BadRequestError();
            else {
              try {
                return BadRequestError(
                    message:
                        "${AddAddressRequest.fromMap(error.response?.data).validationErrors[0]?.erros[0]}");
              } catch (ex) {
                return BadRequestError(message: "error performing action");
              }
            }
            break;
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            if (error.response?.data["message"] == null) {
              return InternalServerError();
            } else if (error.response?.data["data"] == null) {
              return CustomError(message: error.response.data["message"]);
            }

            break;
          default:
            return HttpError();
        }
      }
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    }
    return UnknownError();
  }
}
