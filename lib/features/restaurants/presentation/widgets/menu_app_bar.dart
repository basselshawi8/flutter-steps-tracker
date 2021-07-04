import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/rate_widget.dart';

class MenuAppBar extends StatelessWidget {
  final RestaurantEntity restaurant;

  const MenuAppBar({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,

      margin: EdgeInsets.symmetric(horizontal: 60.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),

          Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.chevron_left, color: CoreStyle.restaurantHeaderColor,
                  size: 90.h,)
                ,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 30.w,),
              Text(
                restaurant.name,
                style: TextStyle(
                    color: CoreStyle.restaurantHeaderColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            restaurant.cuisine,
            style: TextStyle(
                color: CoreStyle.restaurantHeaderColor,
                fontSize: 35.sp,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RateWidget(
                rate: restaurant.rate,
              ),
              Text(
                "Open Now",
                style: TextStyle(
                    color: CoreStyle.primaryTheme,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
