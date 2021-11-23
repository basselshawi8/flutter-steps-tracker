import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/main.dart';
import 'package:provider/provider.dart';

class ToggleWidget extends StatefulWidget {
  final String name;
  final String image;
  final Function(bool) valueUpdated;
  final bool initialValue;

  const ToggleWidget(
      {Key key, this.name, this.valueUpdated, this.image, this.initialValue})
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
  Animation _thumbLocation;
  Animation _textLocation;

  bool _val;

  @override
  void initState() {
    _val = widget.initialValue ?? false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _backgroundColorAnimation = ColorTween(
            begin: Color(0xFF313131), end: CoreStyle.operationGreenContent)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _thumbLocation = Tween<double>(begin: 15.w, end: 110.w)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _textLocation = Tween<double>(begin: 110.w, end: 15.w)
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
            border: Border.all(color: Color(0xFF3E3E3E), width: 0.5.w),
            borderRadius: BorderRadius.circular(12.r)),
        child: Stack(
          children: [
            Positioned(
              top: 10.w,
              left: _thumbLocation.value,
              child: Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                    color: CoreStyle.white,
                    borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
            Positioned(
                top: 5.h,
                bottom: 5.h,
                left: _textLocation.value,
                child: Container(
                  width: 35.w,
                  child: FittedBox(
                    child: Image.asset(
                      widget.image,
                      color: CoreStyle.white,
                      width: 25.w,
                      height: 25.w,
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
  Offset offset = Offset(0, 0);
  var firstFetch = false;
  Future<Offset> futureOffset;

  @override
  void initState() {
    futureOffset = SpUtil.getOffset(POSITION_AI_WIDGET);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOffset,
      builder: (context, snapshot) {
        if (snapshot.hasData && firstFetch == false) {
          firstFetch = true;
          offset = (snapshot.data as Offset);
        }
        return Positioned(
            bottom: Provider.of<ActionsChangeNotifier>(context).rcMode == false
                ? 355.h
                : 625.h,
            right: 20.w,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset =
                      offset.translate(-details.delta.dy, details.delta.dx);
                  SpUtil.putOffset(POSITION_AI_WIDGET, offset);
                });
              },
              child: Container(
                width: 400.w,
                height: 120.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: CoreStyle.operationBlackColor,
                    borderRadius: BorderRadius.circular(34.r),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10.r,
                          offset: Offset(0, 5.h),
                          color: CoreStyle.operationShadowColor)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),
                        Expanded(
                          child: Text(
                            "AI Mode",
                            style: TextStyle(
                                color: Color(0xFF6E6E6E),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Container(
                          width: 160.w,
                          height: 60.w,
                          child: ToggleWidget(
                            name: "AI Mode",
                            image: IMG_AI_MODE,
                            valueUpdated: (val) {
                              mqttHelper.publishAi(val);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),
                        Expanded(
                          child: Text(
                            "RC Mode",
                            style: TextStyle(
                                color: Color(0xFF6E6E6E),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Container(
                          width: 160.w,
                          height: 60.w,
                          child: ToggleWidget(
                            name: "RC Mode",
                            image: IMG_RC_MODE,
                            initialValue: Provider.of<ActionsChangeNotifier>(
                                    context,
                                    listen: false)
                                .rcMode,
                            valueUpdated: (val) {
                              Provider.of<ActionsChangeNotifier>(context,
                                      listen: false)
                                  .rcMode = !Provider.of<ActionsChangeNotifier>(
                                      context,
                                      listen: false)
                                  .rcMode;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
