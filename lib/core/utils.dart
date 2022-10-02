import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';

showSnackBack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: CoreStyle.tchpinOrangeColor,
      content: Container(
        height: 40.h,
        child: Center(
            child: Text(
          message,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: TchipinFontWeight.regular,
              fontSize: 13.sp),
        )),
      )));
}
