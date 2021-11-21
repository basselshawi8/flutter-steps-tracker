import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:provider/provider.dart';

class ChangeVehicleWidget extends StatefulWidget {
  final String vehicle;

  const ChangeVehicleWidget({Key key, this.vehicle}) : super(key: key);

  @override
  _ChangeVehicleWidgetState createState() {
    return _ChangeVehicleWidgetState();
  }
}

class _ChangeVehicleWidgetState extends State<ChangeVehicleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  double accumlateAngle = 0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    if (widget.vehicle == "m2")
      _animation =
          Tween<double>(begin: accumlateAngle, end: accumlateAngle + pi)
              .animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInExpo));
    else
      _animation =
          Tween<double>(begin: accumlateAngle, end: accumlateAngle + pi / 2)
              .animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut));

    accumlateAngle += widget.vehicle == "m1" ? pi / 2 : pi;
    _animationController.addListener(() {
      if (Provider.of<ActionsChangeNotifier>(context, listen: false)
              .showChangeVehicle ==
          true) setState(() {});
    });

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (Provider.of<ActionsChangeNotifier>(context, listen: false)
              .showChangeVehicle ==
          true) {
        if (status == AnimationStatus.completed) {
          if (widget.vehicle == "m2")
            _animation = Tween<double>(begin: 0, end: pi).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInExpo));
          else
            _animation = Tween<double>(
                    begin: accumlateAngle, end: accumlateAngle + pi / 2)
                .animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut));

          accumlateAngle += widget.vehicle == "m1" ? pi / 2 : pi;
          _animationController.reset();
          _animationController.forward();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    _animationController.removeStatusListener((status) {});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Container(
      color: Color(0xFF1C1C1C),
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 0.8,
              child: Image.asset(
                  widget.vehicle == "m1" ? IMG_M1_VEHICLE : IMG_M2_VEHICLE),
            ),
          ),
          Positioned(
              bottom: -40.h,
              left: (1920 / 2).w - 40.w,
              child: Transform.rotate(
                angle: _animation.value,
                child: Container(
                  width: 80.w,
                  height: 150.h,
                  child: Image.asset(widget.vehicle == "m1"
                      ? IMG_M1_ANIMATION
                      : IMG_M2_ANIMATION),
                ),
              ))
        ],
      ),
    ));
  }
}
