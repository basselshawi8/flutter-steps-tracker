import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/features/incident/presentation/notifiers/incidents_notifier.dart';
import 'package:provider/provider.dart';

class PinnedWidget extends StatefulWidget {
  @override
  _PinnedWidgetState createState() {
    return _PinnedWidgetState();
  }
}

class _PinnedWidgetState extends State<PinnedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _scanAnimation;
  Animation _arrowAnimation;
  Animation _counterAnimation;

  @override
  void initState() {
    // TODO: implement initState

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller.addListener(() {
      setState(() {});
    });
    _scanAnimation = Tween<double>(begin: 0, end: 20.w)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _arrowAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _counterAnimation = Tween<double>(begin: 26.sp, end: 32.5.sp)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 1920.w / 2 - 200.w,
      top: 30.h,
      child: GestureDetector(
        onTap: () {
          if (_controller.value == 0) {
            _controller.forward();
            Provider.of<ActionsChangeNotifier>(context, listen: false)
                .showPinnedActions = true;
          } else {
            _controller.reverse();
            Provider.of<ActionsChangeNotifier>(context, listen: false)
                .showPinnedActions = false;
          }
        },
        child: Container(
          width: 400.w,
          height: 50.h,
          decoration: BoxDecoration(
              color: CoreStyle.operationGreyContent,
              border: Border.all(
                  color: CoreStyle.operationBorder2Color, width: 3.w),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 30.r,
                    offset: Offset(0, 11.h),
                    color: CoreStyle.operationShadowColor)
              ]),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                  offset: Offset(_scanAnimation.value, 0),
                  child: Image.asset(
                    IMG_SCAN,
                    width: 40.w,
                  )),
              Expanded(child: SizedBox()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pinned",
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: CoreStyle.white),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Transform.translate(
                    offset: Offset(0, 2.5.h),
                    child: Transform.rotate(
                      angle: _arrowAnimation.value,
                      child: Image.asset(
                        IMG_DOWN_ARROW,
                        width: 22.w,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(child: SizedBox()),
              Container(
                width: 30.w,
                height: double.maxFinite,
                child: Center(
                  child: Consumer<IncidentsChangeNotifier>(
                    builder: (context, state, _) {
                      return Text(
                        state.incidents == null || state.incidents.length == 0
                            ? "4"
                            : state.incidents.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: _counterAnimation.value,
                            fontWeight: FontWeight.w500,
                            color: CoreStyle.white),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
