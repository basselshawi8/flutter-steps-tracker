import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/errors/cancel_error.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/user_managment/presentation/screen/main_navigation_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  var _isAsync = false;

  var _cancelToken = CancelToken();

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listenWhen: (previous, current) {
        if (current is GetUsersSuccessState ||
            current is GetUsersFailureState) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        setState(() {
          _isAsync = false;
        });
        if (state is GetUsersSuccessState) {
          for (var user in state.users.data) {
            if (user.password.toLowerCase() ==
                    passwordController.text.toLowerCase() &&
                user.username.toLowerCase() ==
                    usernameController.text.toLowerCase()) {
              Navigator.of(context)
                  .pushReplacementNamed(MainNavigationPage.routeName);
              return;
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                height: 40.h,
                child: Center(
                  child: Text("Username or Password Incorrect"),
                ),
              )));
        } else if (state is GetUsersFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 40.h,
            child: Center(
              child: Text(state.error.toString()),
            ),
          )));
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: _isAsync,
        child: Container(
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
                    setState(() {
                      _isAsync = true;
                    });
                    BlocProvider.of<UserManagementBloc>(context)
                        .add(GetUsers(NoParams(cancelToken: _cancelToken)));
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
                            fontFamily:
                                CoreStyle.fontWithWeight(FontWeight.w300)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
