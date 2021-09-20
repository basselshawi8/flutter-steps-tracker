import 'package:flutter/material.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/user_managment/presentation/screen/main_navigation_screen.dart';

import 'login_text_field.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() {
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<LoginWidget> {
  var usernameFocusNode = FocusNode();
  var usernameKey = GlobalKey<FormFieldState>();
  var usernameController = TextEditingController();

  var passwordFocusNode = FocusNode();
  var passwordKey = GlobalKey<FormFieldState>();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Welcome",
            style: TextStyle(
                color: CoreStyle.operationTextBlueColor,
                fontSize: 27.sp,
                fontFamily: CoreStyle.fontWithWeight(FontWeight.w700)),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            "Please enter your credentials",
            style: TextStyle(
                color: CoreStyle.operationTextBlueColor.withOpacity(0.81),
                fontSize: 18.sp,
                fontFamily: CoreStyle.fontWithWeight(FontWeight.w500)),
          ),
          SizedBox(
            height: 36.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 200.w),
            child: LoginTextField(
              helperText: "Username",
              textInputAction: TextInputAction.next,
              focusNode: usernameFocusNode,
              key: usernameKey,
              controller: usernameController,
              onFieldSubmitted: (val) {
                passwordFocusNode.requestFocus();
              },
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 200.w),
            child: LoginTextField(
              helperText: "Password",
              obscureText: true,
              textInputAction: TextInputAction.done,
              focusNode: passwordFocusNode,
              key: passwordKey,
              controller: passwordController,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 200.w),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(MainNavigationPage.routeName);
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: CoreStyle.operationDarkGreen),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: CoreStyle.white,
                        fontSize: 14.sp,
                        fontFamily: CoreStyle.fontWithWeight(FontWeight.w300)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
