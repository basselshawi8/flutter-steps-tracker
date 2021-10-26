import 'dart:convert';
import 'package:micropolis_test/core/params/base_params.dart';

class CreateFacialParam extends BaseParams {
  final String vehicle_id;
  final int fr_accuracy_value;
  final double fr_frame_size;
  final bool fr_active;
  final int fr_process_frame;
  final int fr_cached_faces;
  final int vs_number_of_frames;

  CreateFacialParam(
      {this.vehicle_id,
      this.fr_accuracy_value,
      this.fr_frame_size,
      this.fr_active,
      this.fr_process_frame,
      this.fr_cached_faces,
      this.vs_number_of_frames});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "fr_accuracy_value": fr_accuracy_value,
        "fr_frame_size": fr_frame_size,
        "fr_active": fr_active == true ? 1 : 0,
        "fr_process_frame": fr_process_frame,
        "fr_cached_faces": fr_cached_faces,
        "vs_number_of_frames": vs_number_of_frames
      };
}
