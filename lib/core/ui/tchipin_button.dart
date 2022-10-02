import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';

class TchipinButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Icon? icon;
  final Icon? prefixIcon;
  final EdgeInsets? padding;

  const TchipinButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.padding,
      this.prefixIcon,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      padding: this.padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19.h),
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(

              decoration: BoxDecoration(
                  color: CoreStyle.tchpinOrangeColor,
                  borderRadius: BorderRadius.circular(19.h)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (this.prefixIcon != null) ...[this.prefixIcon!,SizedBox(width: 8.w,)],
                    Text(
                      this.text,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10.sp,
                          color: CoreStyle.tchpinWhiteColor,
                          fontWeight: TchipinFontWeight.regular),
                    ),
                    if (this.icon != null) ...[
                      SizedBox(
                        width: 5.w,
                      ),
                      this.icon!
                    ]
                  ],
                ),
              ),
            )),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: CoreStyle.white.withOpacity(0.3),
                onTap: () {
                  this.onPressed();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class TchipinActionButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;

  const TchipinActionButton(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 38.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19.h),
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  color: CoreStyle.tchpinOrangeColor,
                  borderRadius: BorderRadius.circular(19.h)),
              child: Center(
                child: this.icon,
              ),
            )),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: CoreStyle.white.withOpacity(0.3),
                onTap: () {
                  this.onPressed();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
