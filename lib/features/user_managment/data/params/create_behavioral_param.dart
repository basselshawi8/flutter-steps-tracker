import 'dart:convert';
import 'package:micropolis_test/core/params/base_params.dart';

class CreateBehavioralParam extends BaseParams {
  final String vehicle_id;
  final int ba_img_size;
  final int ba_images_per_file;
  final bool ba_active;

  CreateBehavioralParam(
      {this.vehicle_id,
      this.ba_img_size,
      this.ba_images_per_file,
      this.ba_active});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "vehicle_id": vehicle_id,
        "ba_img_size": ba_img_size,
        "ba_images_per_file": ba_images_per_file,
        "ba_active": ba_active == true ? 1 : 0,
      };
}
