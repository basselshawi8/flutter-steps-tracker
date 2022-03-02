import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/errors/custom_error.dart';
import 'package:micropolis_test/core/http/models_factory.dart';
import 'package:micropolis_test/core/models/BaseModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../errors/base_error.dart';
import '../http/api_provider.dart';
import '../http/http_method.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, T>> request<T extends BaseModel>({
    required T Function(dynamic) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String? dataString,
    bool withAuthentication = false,
    bool withCurrency = false,
    bool isList = false,
    String? baseURL,
    CancelToken? cancelToken,
  }) async {
    ModelsFactory.getInstance().registerModel(T.toString(), converter, isList);
    // Specify the headers.
    final Map<String, dynamic> headers = {};
    // Get the language.
    String lang = await appConfig.currentLanguage();

    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);

    print(headers);
    // Get auth token (if withAuthentication)
    if (withAuthentication) {
      headers.putIfAbsent(HEADER_AUTH, () => 'token goes here');
    }

    // Send the request.
    final response = await ApiProvider.getInstance().sendRequest<T>(
      method: method,
      url: url,
      headers: headers,
      baseURL: baseURL,
      queryParameters: queryParameters ?? {},
      data: data,
      dataString: dataString,
      cancelToken: cancelToken,
    );

    if (response.isLeft()) {
      return Left((response as Left<BaseError, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<BaseError, T>).value;
        return Right(resValue);
      } catch (e) {
        print(e);
        return Left(CustomError(message: "Catch error in remote data source"));
      }
    } else
      return Left(CustomError(message: "Unknown Error"));
  }

  Future<Either<BaseError, T>> requestUploadFile<T extends BaseModel>({
    required T Function(dynamic) converter,
    required String url,
    required String fileKey,
    required String filePath,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    bool isList = false,
    CancelToken? cancelToken,
  }) async {
    ModelsFactory.getInstance().registerModel(T.toString(), converter, isList);

    // Specify the headers.
    final Map<String, String> headers = {};

    // Get the language.
    String lang = await appConfig.currentLanguage();
    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);

    print(
        '-------------------------------:upload remote:-------------------------------');
    debugPrint(headers.toString());
    debugPrint(filePath);
    debugPrint(fileKey);

    // Get auth token (if withAuthentication)
    if (withAuthentication) {
      headers.putIfAbsent(HEADER_AUTH, () => 'token goes here');
    }
    print(headers);

    // Send the request.
    var response;
    try {
      response = await ApiProvider.getInstance().upload<T>(
        url: url,
        fileKey: fileKey,
        filePath: filePath,
        fileName: filePath?.substring(filePath.lastIndexOf('/') + 1),
        headers: headers,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } catch (e) {
      return Left(CustomError(message: e is String ? e : "Error"));
    }

    if (response.isLeft()) {
      return Left((response as Left<BaseError, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<BaseError, T>).value;
        return Right(resValue);
      } catch (e) {
        print(e);
        return Left(CustomError(message: "Catch error in remote data source"));
      }
    } else
      return Left(CustomError(message: "Unknown Error"));
  }
}
