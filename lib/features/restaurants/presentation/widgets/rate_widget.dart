import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';

class RateWidget extends StatelessWidget {
  final int? rate;

  const RateWidget({Key? key, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: 50.h,
            height: 50.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
                border: Border.all(
                    color: CoreStyle.restaurantBorderColor, width: 5.w),
                color: (rate ?? 5) > index
                    ? CoreStyle.restaurantYellowColor
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(25.h))),
          );
        },
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
