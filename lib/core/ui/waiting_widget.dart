import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Common/CoreStyle.dart';

class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      child: Center(
        child: const CircularProgressIndicator(
          color: CoreStyle.tchpinOrangeColor,
        ),
      ),
    );
  }
}
