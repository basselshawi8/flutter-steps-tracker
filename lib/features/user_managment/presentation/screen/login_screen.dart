import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: double.maxFinite,
                width: (1920 / 2).w,
                color: CoreStyle.operationIncidentListBlackColor,
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      IMG_DUBAI_POLICE,
                      height: 200.w,
                      width: 200.w,
                    ),
                    Text(
                      "Autonomous Police Patrol",
                      style: TextStyle(
                        color: CoreStyle.white.withOpacity(0.81),
                        fontSize: 20.sp,
                        fontFamily: CoreStyle.fontWithWeight(FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              left: (1920 / 2).w,
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: double.maxFinite,
                width: (1920 / 2).w,
                color: CoreStyle.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          color: CoreStyle.operationTextBlueColor,
                          fontSize: 16.sp,
                          fontFamily:
                              CoreStyle.fontWithWeight(FontWeight.w700)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1.h,
                      color: CoreStyle.operationBlackColor.withOpacity(0.1),
                    ),
                    Expanded(
                        flex: 9,
                        child: SizedBox(
                          height: 10.h,
                        )),
                    Expanded(
                      child: LoginWidget(),
                      flex: 10,
                    ),
                    Expanded(
                        flex: 9,
                        child: SizedBox(
                          height: 10.h,
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
