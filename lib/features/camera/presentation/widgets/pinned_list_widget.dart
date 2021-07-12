import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:provider/provider.dart';

class PinnedListWidget extends StatefulWidget {
  @override
  _PinnedListWidgetState createState() {
    return _PinnedListWidgetState();
  }
}

class _PinnedListWidgetState extends State<PinnedListWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _moveAnimation;
  var texts = [
    "Robbery Susp.",
    "Robbery Susp.",
    "Robbery Susp.",
    "Robbery Susp.",
    "Robbery Susp.",
    "Robbery Susp.",
    "Robbery Susp."
  ];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _moveAnimation = Tween<double>(begin:-301.h , end:100.h ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInToLinear));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionsChangeNotifier>(
      builder: (context, state, _) {
        if (state.showPinnedActions == true) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        return Positioned(
          left: 1920.w / 2 - 400.w,
          top: _moveAnimation.value,
          child: Container(
            width: 800.w,
            height: 200.h,
            decoration: BoxDecoration(
                color: CoreStyle.operationBlackColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 50.r,
                      offset: Offset(0, 23.h),
                      color: CoreStyle.operationShadowColor)
                ]),

            child: ListView.builder(itemBuilder: (context,index){


              return index == 0 ? SizedBox(width: 20.w,) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    height: 120.h,
                    width: 120.h,
                    decoration: BoxDecoration(
                      color: CoreStyle.operationBlack3Color,
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  SizedBox(height: 8.h,),
                  Text(texts[index-1],style: TextStyle(color: CoreStyle.white,fontSize: 17.sp),)
                ],
              );
            },
              scrollDirection: Axis.horizontal,
              itemCount: texts.length + 1,
            ),
          ),
        );
      },
    );
  }
}
