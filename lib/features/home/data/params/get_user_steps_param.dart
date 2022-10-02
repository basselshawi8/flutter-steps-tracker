

import 'package:micropolis_test/core/params/base_params.dart';

class GetUserStepsParam extends BaseParams {
  final String deviceId;

  GetUserStepsParam({required this.deviceId, cancelToken})
      : super(cancelToken: cancelToken);
}
