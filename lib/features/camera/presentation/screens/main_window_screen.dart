import 'dart:async';

import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/ai_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_direction_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/incidents_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/main_navigation_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/pinned_list_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/pinned_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainWindowScreen extends StatefulWidget {
  @override
  _MainWindowScreenState createState() {
    return _MainWindowScreenState();
  }
}

class _MainWindowScreenState extends State<MainWindowScreen> {
  var urls = [
    'ws://127.0.0.1:9502',
    'wss://echo.websocket.org'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          CameraWidget(
            position: Offset(0, 0),
            size: Size(1920.w, 1080.h),
            url: urls[0],
          ),
          CameraWidget(
            position: Offset(32, 32),
            size: Size(217.h, 217.h),
            isMini: true,
            url: urls[1],
            switchCamera: () {
              urls = urls.reversed.toList();
              setState(() {});
            },
          ),
          MainNavigationWidget(),
          CameraDirectionWidget(),
          IncidentsWidget(),
          AIWidget(),
          PinnedListWidget(),
          PinnedWidget(),
          Positioned(
              right: 60.w,
              top: 30.h,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                    width: 220.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: CoreStyle.operationBlackColor.withOpacity(0.77),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          IMG_ROBOT,
                          width: 35.w,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          "DPAP Grand",
                          style: TextStyle(
                              color: CoreStyle.white, fontSize: 20.sp),
                        )
                      ],
                    )),
              ))
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
