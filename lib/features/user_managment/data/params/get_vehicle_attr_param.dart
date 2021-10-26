import 'dart:convert';
import 'package:micropolis_test/core/params/base_params.dart';

class GetVechileParam extends BaseParams {
  final String vechileID;

  GetVechileParam({
    this.vechileID,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {};
}
