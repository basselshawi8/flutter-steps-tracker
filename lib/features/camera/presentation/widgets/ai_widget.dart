import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleWidget extends StatefulWidget {
  final String name;
  final Function(bool) valueUpdated;
  final bool initialValue;

  const ToggleWidget({Key key, this.name, this.valueUpdated, this.initialValue})
      : super(key: key);

  @override
  _ToggleWidgetState createState() {
    // TODO: implement createState
    return _ToggleWidgetState();
  }
}

class _ToggleWidgetState extends State<ToggleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _backgroundColorAnimation;
  Animation _thumbColorAnimation;
  Animation _thumbLocation;
  Animation _textLocation;

  bool _val;

  @override
  void initState() {
    _val = widget.initialValue ?? false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _backgroundColorAnimation = ColorTween(
            begin: CoreStyle.operationBorderColor,
            end: CoreStyle.operationGreenContent)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _thumbColorAnimation = ColorTween(
            begin: CoreStyle.operationBorder2Color, end: CoreStyle.white)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _thumbLocation = Tween<double>(begin: 10.w, end: 100.w)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _textLocation = Tween<double>(begin: 100.w, end: 16.w)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.addListener(() {
      setState(() {});
    });

    if (_val == true) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _val = !_val;
        if (_val == true) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        if (widget.valueUpdated != null) widget.valueUpdated(_val);
      },
      child: Container(

        decoration: BoxDecoration(
            color: _backgroundColorAnimation.value,
            borderRadius: BorderRadius.circular(22.r)),
        child: Stack(
          children: [
            Positioned(
              top: 5.h,
              left: _thumbLocation.value,
              child: Container(
                height: 60.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: _thumbColorAnimation.value,
                    borderRadius: BorderRadius.circular(17.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: _val == false
                          ? BoxDecoration(
                              border: Border.all(
                                  color: CoreStyle.White200, width: 4.w),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )
                          : null,
                      height: _val == false ? 30.w : 35.w,
                      width: _val == false ? 30.w : 4.w,
                      color:
                          _val == false ? null : CoreStyle.operationBlack2Color,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 5.h,
                bottom: 5.h,
                left: _textLocation.value,
                child: Container(
                  width: 40.w,
                  child: FittedBox(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 37.sp,
                          color: CoreStyle.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class AIWidget extends StatefulWidget {
  @override
  _AIWidgetState createState() {
    return _AIWidgetState();
  }
}

class _AIWidgetState extends State<AIWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 32.w,
        left: 32.w,
        child: Container(
          width: 440.w,
          height: 77.h * 1.2,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
              color: CoreStyle.operationBlackColor,
              border:
                  Border.all(color: CoreStyle.operationBorderColor, width: 2.h),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 40.r,
                    offset: Offset(0,  10.h),
                    color: CoreStyle.operationShadowColor)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160.w,
                height: 70.h,
                child: ToggleWidget(
                  name: "AI",
                  valueUpdated: (val) {
                    print(val);
                  },
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Container(
                width: 160.w,
                height: 70.h,
                child: ToggleWidget(
                  name: "RC",
                  initialValue: true,
                  valueUpdated: (val) {
                    print(val);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
