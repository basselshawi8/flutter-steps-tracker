import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:micropolis_test/features/restaurants/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/restaurant_list_item.dart';

class RestaurantsScreenContent extends StatefulWidget {
  final RestaurantListEntity? restaurants;

  const RestaurantsScreenContent({Key? key, this.restaurants})
      : super(key: key);

  @override
  _RestaurantsScreenContentState createState() {
    return _RestaurantsScreenContentState();
  }
}

class _RestaurantsScreenContentState extends State<RestaurantsScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(60.w, 100.h, 60.w, 24.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Best New York City restaurants",
          style: TextStyle(
              color: CoreStyle.restaurantHeaderColor,
              fontWeight: FontWeight.w900,
              fontSize: 81.sp),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.restaurants?.restaurants?.length ?? 0,
            itemBuilder: (context, index) {
              return RestaurantListItemWidget(
                restaurant: widget.restaurants!.restaurants![index],
              );
            },
          ),
        ),
      ]),
    );
  }
}
