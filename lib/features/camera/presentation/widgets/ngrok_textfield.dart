import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/features/camera/presentation/screens/main_window_screen.dart';
import 'package:micropolis_test/main.dart';

class NgrokWidget extends StatefulWidget {
  final Function doneEditing;

  const NgrokWidget({Key key, this.doneEditing}) : super(key: key);

  @override
  _NgrokWidgetState createState() {
    // TODO: implement createState
    return _NgrokWidgetState();
  }
}

class _NgrokWidgetState extends State<NgrokWidget> {
  TextEditingController _textFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20.w,
        top: 300.h,
        child: GestureDetector(
          onTap: () {
            mqttHelper.initConnection();
          },
          child: Container(
            decoration: BoxDecoration(
                color: CoreStyle.operationBlack2Color,
                borderRadius: BorderRadius.circular(12.r)),
            width: 200.w,
            height: 70.h,
            child: Center(
              child: Text(
                "Reset MQTT",
                style: TextStyle(color: CoreStyle.white, fontSize: 18.sp),
              ),
            ),
          ),
        ));
  }
}
