import 'dart:convert';
import 'package:micropolis_test/core/params/base_params.dart';

class CreateHumanDetectionParam extends BaseParams {
  final String vechileID;
  final bool hd;

  CreateHumanDetectionParam({this.vechileID, this.hd});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "HD": hd == true ? 1 : 0,
      };
}
