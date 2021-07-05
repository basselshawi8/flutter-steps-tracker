import 'package:flutter/material.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/ai_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_direction_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/camera_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/incidents_widget.dart';
import 'package:micropolis_test/features/camera/presentation/widgets/main_navigation_widget.dart';

class MainWindowScreen extends StatefulWidget {
  @override
  _MainWindowScreenState createState() {
    return _MainWindowScreenState();
  }
}

class _MainWindowScreenState extends State<MainWindowScreen> {
  var urls = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    print("build again");
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
          AIWidget()
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
