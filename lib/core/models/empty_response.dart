import 'package:micropolis_test/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

import 'BaseModel.dart';

class EmptyResponse extends BaseModel {
  final bool succeed;
  final String message;


  EmptyResponse({
    @required this.succeed,
    @required this.message,
  });


  factory EmptyResponse.fromMap(Map<String, dynamic> json) => EmptyResponse(
    succeed: json["succeed"] == null ? null : json["succeed"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "succeed": succeed == null ? null : succeed,
    "message": message == null ? null : message,
  };

  @override
  BaseEntity toEntity() {
    throw UnimplementedError();
  }
}
