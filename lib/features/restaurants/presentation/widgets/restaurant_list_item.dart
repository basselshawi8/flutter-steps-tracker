import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/restaurants/domain/entity/restaurant_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/restaurants/presentation/screen/menu_screen.dart';
import 'package:micropolis_test/features/restaurants/presentation/widgets/rate_widget.dart';

class RestaurantListItemWidget extends StatelessWidget {
  final RestaurantEntity restaurant;

  const RestaurantListItemWidget({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        Container(
          height: 900.h,
          decoration: BoxDecoration(
              color: CoreStyle.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2.h),
                    spreadRadius: 2.r,
                    color: CoreStyle.restaurantShadowColor,
                    blurRadius: 8.r)
              ],
              borderRadius: BorderRadius.all(Radius.circular(30.h))),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: true,

                        viewportFraction: 1.0,
                        height: 650.h,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: restaurant.images.length,
                      itemBuilder: (BuildContext context, int itemIndex) =>
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(22.h),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.h)),
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage(IMG_NETWORK_PLACEHOLDER),
                                  image: NetworkImage(
                                      restaurant.images[itemIndex]),
                                  fit: BoxFit.cover,
                                ),
                              )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22.h),
                      child: Text(
                        restaurant.name,
                        style: TextStyle(
                            color: CoreStyle.restaurantHeaderColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22.h),
                      child: Text(
                        restaurant.cuisine,
                        style: TextStyle(
                            color: CoreStyle.restaurantHeaderColor,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Row(
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
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                  child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MenuScreen.routeName, arguments: {
                        "restaurant": restaurant,
                      });
                    },
                    splashColor: CoreStyle.primaryTheme.withOpacity(0.3),
                    highlightColor: Colors.transparent,
                  ),
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
