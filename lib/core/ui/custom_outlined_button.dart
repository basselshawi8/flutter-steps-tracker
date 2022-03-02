import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Function? onPressed;

  const CustomOutlinedButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      height: 80.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(12.h)),
          border: Border.all(color: CoreStyle.primaryTheme, width: 3.w)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onPressed != null) onPressed!();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: CoreStyle.primaryTheme,
                  fontWeight: FontWeight.w400,
                  fontSize: 35.sp),
            ),
          ),
        ),
      ),
    );
  }
}
