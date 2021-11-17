import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';

class VehicleSelector extends StatefulWidget {
  final Function(String) valueChanged;

  const VehicleSelector({Key key, this.valueChanged}) : super(key: key);

  @override
  _VehicleSelectorState createState() {
    return _VehicleSelectorState();
  }
}

class _VehicleSelectorState extends State<VehicleSelector>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _thumbAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _thumbAnimation = Tween<double>(begin: 0, end: 130.h).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.decelerate));
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250.h,
      left: 0.w,
      child: GestureDetector(
        onTap: () {
          if (_animationController.value == 0) {
            _animationController.forward();
            widget.valueChanged("m1");
          } else {
            _animationController.reverse();
            widget.valueChanged("m2");
          }
        },
        child: Container(
          width: 190.w,
          height: 270.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(42.r)),
                      color: CoreStyle.operationBlackColor),
                ),
              ),
              Positioned(
                  bottom: _thumbAnimation.value,
                  left: 30.w,
                  child: Container(
                    width: 130.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF02A76F),
                        borderRadius: BorderRadius.circular(42.r),
                        border:
                            Border.all(color: Color(0xFF02C380), width: 0.5.w),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x0000009F),
                              blurRadius: 20,
                              spreadRadius: 4)
                        ]),
                  )),
              Positioned(
                  top: 38.h,
                  left: 38.w,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    margin: EdgeInsets.all(16.0.w),
                    child: Image.asset(_animationController.value == 0
                        ? IMG_M1_UNSELECTED
                        : IMG_M1_SELECTED),
                  )),
              Positioned(
                  bottom: _animationController.value == 0 ? 16.h : 30.h,
                  left: 38.w,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    margin: EdgeInsets.all(16.0.w),
                    child: Image.asset(_animationController.value == 0
                        ? IMG_M2_SELECTED
                        : IMG_M2_UNSELECTED),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
