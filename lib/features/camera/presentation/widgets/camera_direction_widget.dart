import 'dart:math';

import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/camera/presentation/notifiers/actions_change_notifier.dart';
import 'package:micropolis_test/main.dart';
import 'package:micropolis_test/mqtt_helper.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'direction_widget.dart';

class CameraDirectionWidget extends StatefulWidget {
  @override
  _CameraDirectionWidgetState createState() {
    // TODO: implement createState
    return _CameraDirectionWidgetState();
  }
}

class _CameraDirectionWidgetState extends State<CameraDirectionWidget> {
  var _currentDirection = Directions.none;
  var offset = Offset(0, 0);
  var firstFetch = false;
  int _currentAccumValue = 10;
  Timer _accumTimer;
  Future<Offset> futureOffset;

  @override
  void initState() {
    futureOffset = SpUtil.getOffset(POSITION_CAMERA_DIRECTION_WIDGET);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _accumTimer?.cancel();
    super.dispose();
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
                ? 0
                : 270.h,
            right: -20.w,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset =
                      offset.translate(details.delta.dy, -details.delta.dx);
                  SpUtil.putOffset(POSITION_CAMERA_DIRECTION_WIDGET, offset);
                });
              },
              child: Container(
                width: 360.h,
                height: 360.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        IMG_CAMERA_MOVEMENT,
                      ),
                    ),
                    Positioned(
                      top: 88.5.h +
                          (_currentDirection == Directions.bottom
                              ? 10.h
                              : _currentDirection == Directions.top
                                  ? -10.h
                                  : 0),
                      left: 97.5.h +
                          (_currentDirection == Directions.right
                              ? 10.h
                              : _currentDirection == Directions.left
                                  ? -10.h
                                  : 0),
                      child: Image.asset(
                        IMG_WHEEL_GREY,
                        width: 165.h,
                        height: 165.h,
                      ),
                    ),
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          var width = constraints.maxWidth;
                          var height = constraints.maxHeight;
                          return GestureDetector(
                            onTapDown: (details) {
                              _accumTimer?.cancel();
                              _accumTimer =
                                  Timer.periodic(Duration(seconds: 1), (timer) {
                                _currentAccumValue += 10;
                                _currentAccumValue =
                                    min(_currentAccumValue, 100);
                                if (details.localPosition.dy < height / 3.5) {
                                  setState(() {
                                    _currentDirection = Directions.top;
                                  });
                                } else if (details.localPosition.dx <
                                    width / 3.5) {
                                  setState(() {
                                    _currentDirection = Directions.left;
                                  });
                                } else if (details.localPosition.dx >
                                    width * 0.65) {
                                  setState(() {
                                    _currentDirection = Directions.right;
                                  });
                                } else if (details.localPosition.dy >
                                    height * 0.65) {
                                  setState(() {
                                    _currentDirection = Directions.bottom;
                                  });
                                } else {
                                  setState(() {
                                    _currentDirection = Directions.none;
                                  });
                                }

                                _sendDirectionToMqtt();
                              });
                              if (details.localPosition.dy < height / 3.5) {
                                _currentDirection = Directions.top;
                              } else if (details.localPosition.dx <
                                  width / 3.5) {
                                _currentDirection = Directions.left;
                              } else if (details.localPosition.dx >
                                  width * 0.65) {
                                _currentDirection = Directions.right;
                              } else if (details.localPosition.dy >
                                  height * 0.65) {
                                _currentDirection = Directions.bottom;
                              } else {
                                _currentDirection = Directions.none;
                              }
                              _sendDirectionToMqtt();
                            },
                            onTapUp: (details) {
                              setState(() {
                                _currentDirection = Directions.none;
                                _accumTimer?.cancel();
                                if (_currentAccumValue >= 80) {
                                  mqttHelper.publishStop();
                                }
                                _currentAccumValue = 10;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                _currentDirection = Directions.none;
                                _accumTimer?.cancel();
                                if (_currentAccumValue >= 80) {
                                  mqttHelper.publishStop();
                                }
                                _currentAccumValue = 10;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 70.h,
                      left: 60.h,
                      child: GestureDetector(
                        onTapDown: (details) {
                          _accumTimer =
                              Timer.periodic(Duration(seconds: 1), (timer) {
                            _currentAccumValue += 10;
                            _currentAccumValue = min(_currentAccumValue, 100);
                            mqttHelper.publishCameraZoom(
                                _currentAccumValue, CameraMovement.ZoomOut);
                          });
                          mqttHelper.publishCameraZoom(
                              _currentAccumValue, CameraMovement.ZoomOut);
                        },
                        onTapUp: (details) {
                          _currentDirection = Directions.none;
                          _accumTimer?.cancel();
                          _currentAccumValue = 10;
                        },
                        onTapCancel: () {
                          _currentDirection = Directions.none;
                          _accumTimer?.cancel();
                          _currentAccumValue = 10;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: CoreStyle.operationBlack2Color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                    color: CoreStyle.operationShadowColor,
                                    blurRadius: 10.r,
                                    offset: Offset(0, 4))
                              ]),
                          width: 68.h,
                          height: 68.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                ),
                                color: CoreStyle.operationBorder2Color,
                                height: 4.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70.h,
                      right: 60.h,
                      child: GestureDetector(
                        onTapDown: (details) {
                          _accumTimer =
                              Timer.periodic(Duration(seconds: 1), (timer) {
                            _currentAccumValue += 10;
                            _currentAccumValue = min(_currentAccumValue, 100);
                            mqttHelper.publishCameraZoom(
                                _currentAccumValue, CameraMovement.ZoomIn);
                          });
                          mqttHelper.publishCameraZoom(
                              _currentAccumValue, CameraMovement.ZoomIn);
                        },
                        onTapUp: (details) {
                          _currentDirection = Directions.none;
                          _accumTimer?.cancel();
                          _currentAccumValue = 10;
                        },
                        onTapCancel: () {
                          _currentDirection = Directions.none;
                          _accumTimer?.cancel();
                          _currentAccumValue = 10;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: CoreStyle.operationBlack2Color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                    color: CoreStyle.operationShadowColor,
                                    blurRadius: 10.r,
                                    offset: Offset(0, 4.h))
                              ]),
                          width: 68.h,
                          height: 68.h,
                          child: Container(
                            width: 68.h,
                            height: 68.h,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.h,
                                        ),
                                        color: CoreStyle.operationBorder2Color,
                                        height: 4.h,
                                      )
                                    ])),
                                Positioned.fill(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                      ),
                                      color: CoreStyle.operationBorder2Color,
                                      width: 4.h,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  _sendDirectionToMqtt() {
    if (_currentDirection == Directions.left) {
      mqttHelper.publishCameraPan(_currentAccumValue, CameraMovement.Left);
    } else if (_currentDirection == Directions.right) {
      mqttHelper.publishCameraPan(_currentAccumValue, CameraMovement.Right);
    } else if (_currentDirection == Directions.top) {
      mqttHelper.publishCameraTilt(_currentAccumValue, CameraMovement.Up);
    } else if (_currentDirection == Directions.bottom) {
      mqttHelper.publishCameraTilt(_currentAccumValue, CameraMovement.Down);
    }
  }
}
/*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,),
                          color: CoreStyle.operationBorder2Color,
                          height: 4.h,

                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.w,),
                              color: CoreStyle.operationBorder2Color,
                              width: 4.h,

                            ),
                          ],
                        )
                      ],
                    )*/
