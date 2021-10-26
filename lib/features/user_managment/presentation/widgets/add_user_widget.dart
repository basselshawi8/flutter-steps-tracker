import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/data/models/role_list_model.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_user_param.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'login_text_field.dart';

class AddUserWidget extends StatefulWidget {
  @override
  _AddUserWidgetState createState() {
    return _AddUserWidgetState();
  }
}

class _AddUserWidgetState extends State<AddUserWidget> {
  CancelToken _cancelToken = CancelToken();
  bool _isAsync = false;
  RoleData _currentRole;
  RoleListModel _roles;

  var _firstNameFocusNode = FocusNode();
  var _firstNameKey = GlobalKey<FormFieldState<String>>();
  var _firstNameController = TextEditingController();

  var _surNameFocusNode = FocusNode();
  var _surNameKey = GlobalKey<FormFieldState<String>>();
  var _surNameController = TextEditingController();

  var _emailFocusNode = FocusNode();
  var _emailKey = GlobalKey<FormFieldState<String>>();
  var _emailController = TextEditingController();

  var _mobileFocusNode = FocusNode();
  var _mobileKey = GlobalKey<FormFieldState<String>>();
  var _mobileController = TextEditingController();

  var _loginNameFocusNode = FocusNode();
  var _loginNameKey = GlobalKey<FormFieldState<String>>();
  var _loginNameController = TextEditingController();

  var _passwordFocusNode = FocusNode();
  var _passwordKey = GlobalKey<FormFieldState<String>>();
  var _passwordController = TextEditingController();

  var _confirmPasswordFocusNode = FocusNode();
  var _confirmPasswordKey = GlobalKey<FormFieldState<String>>();
  var _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    _isAsync = true;
    BlocProvider.of<UserManagementBloc>(context)
        .add(GetRoles(NoParams(cancelToken: _cancelToken)));
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listenWhen: (prev, current) {
        if (current is CreateUserSuccessState ||
            current is GetRolesSuccessState ||
            current is CreateUserFailureState ||
            current is GetRolesFailureState) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is GetRolesSuccessState) {
          _roles = state.roles;
          _currentRole = _roles.data.first;
        } else if (state is GetRolesFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 40.h,
            child: Center(
              child: Text(state.error.toString()),
            ),
          )));
        } else if (state is CreateUserFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 40.h,
            child: Center(
              child: Text(state.error.toString()),
            ),
          )));
        } else if (state is CreateUserSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 40.h,
            child: Center(
              child: Text("Success Creating User"),
            ),
          )));

          BlocProvider.of<UserManagementBloc>(context)
              .add(GetUsers(NoParams(cancelToken: _cancelToken)));
          Provider.of<UserManagementChangeNotifier>(context, listen: false)
              .showAddUser = false;
        }

        setState(() {
          _isAsync = false;
        });
      },
      child: ModalProgressHUD(
        inAsyncCall: _isAsync,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 260.h, horizontal: 560.w),
          decoration: BoxDecoration(
              color: CoreStyle.white,
              borderRadius: BorderRadius.circular(12.r)),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      "New User",
                      style: TextStyle(
                          color: CoreStyle.operationTextGrayColor,
                          fontSize: 17.sp,
                          fontFamily:
                              CoreStyle.fontWithWeight(FontWeight.w700)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<UserManagementChangeNotifier>(context,
                              listen: false)
                          .showAddUser = false;
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 242, 242),
                          borderRadius: BorderRadius.circular(18.w)),
                      child: Icon(Icons.close,
                          size: 30.w,
                          color: Color.fromARGB(
                            255,
                            105,
                            105,
                            105,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.maxFinite,
                height: 1.h,
                color: CoreStyle.operationBlack2Color.withOpacity(0.1),
              ),
              SizedBox(
                height: 16.h,
              ),
              _buildUserDetails(),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      _confirmPasswordKey.currentState.validate();
                      _passwordKey.currentState.validate();
                      _loginNameKey.currentState.validate();
                      _emailKey.currentState.validate();
                      _mobileKey.currentState.validate();
                      _surNameKey.currentState.validate();
                      _firstNameKey.currentState.validate();

                      if (_firstNameKey.currentState.isValid &&
                          _surNameKey.currentState.isValid &&
                          _mobileKey.currentState.isValid &&
                          _emailKey.currentState.isValid &&
                          _loginNameKey.currentState.isValid &&
                          _passwordKey.currentState.isValid &&
                          _confirmPasswordKey.currentState.isValid) {
                        setState(() {
                          _isAsync = true;
                        });
                        BlocProvider.of<UserManagementBloc>(context).add(
                            CreateUser(CreateUserParam(
                                rolesIds: [_currentRole.id],
                                name: _firstNameController.text,
                                surname: _surNameController.text,
                                username: _loginNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text)));
                      } else {}
                    },
                    child: Container(
                      width: 120.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: CoreStyle.operationButtonGreenColor,
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Center(
                        child: Text(
                          "Sync",
                          style: TextStyle(
                              color: CoreStyle.white,
                              fontSize: 15.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w300)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _buildUserDetails() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "User Details",
                style: TextStyle(
                    color: CoreStyle.operationTextGrayColor,
                    fontSize: 17.sp,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w700)),
              ),
            ),
            Expanded(
                child: SizedBox(
              width: 10.w,
            )),
            Text(
              "Active",
              style: TextStyle(
                  color: CoreStyle.operationTextGrayColor.withOpacity(
                    0.42,
                  ),
                  fontSize: 18.sp,
                  fontFamily: CoreStyle.fontWithWeight(FontWeight.w400)),
            ),
            SizedBox(
              width: 12.w,
            ),
            CupertinoSwitch(value: true, onChanged: (val) {}),
            SizedBox(
              width: 12.w,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      helperText: "First Name",
                      height: 40.h,
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      textKey: _firstNameKey,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _surNameFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _firstNameKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidName(val) == true
                            ? null
                            : "First Name invalid format";
                      },
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Sur Name",
                      controller: _surNameController,
                      focusNode: _surNameFocusNode,
                      textKey: _surNameKey,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _emailFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _surNameKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidName(val) == true
                            ? null
                            : "Invalid Surname";
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 8,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      helperText: "Email",
                      height: 40.h,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textKey: _emailKey,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _mobileFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _emailKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidEmail(val) == true
                            ? null
                            : "Email invalid format";
                      },
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Mobile",
                      controller: _mobileController,
                      focusNode: _mobileFocusNode,
                      textKey: _mobileKey,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _loginNameFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _mobileKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidPhoneNumber(val) == true
                            ? null
                            : "Phone number invalid format";
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 8,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      helperText: "Login Name",
                      height: 40.h,
                      controller: _loginNameController,
                      focusNode: _loginNameFocusNode,
                      textKey: _loginNameKey,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _passwordFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _loginNameKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidName(val) == true
                            ? null
                            : "Login Name invalid format";
                      },
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Role",
                          style: TextStyle(
                              color: CoreStyle.operationTextBlueColor,
                              fontSize: 15.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w400)),
                        ),
                        if (_roles?.data != null)
                          DropdownButton<String>(
                            value: _currentRole?.name ?? "",
                            items: _roles.data
                                .map((e) => e.name)
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: CoreStyle.operationGrayTextColor,
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (_value) {
                              _currentRole = _roles.data.firstWhere(
                                  (element) => element.name == _value,
                                  orElse: () => null);
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 8,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      helperText: "Password",
                      height: 40.h,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      textKey: _passwordKey,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        _confirmPasswordFocusNode.requestFocus();
                      },
                      onChanged: (val) {
                        _passwordKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidPassword(val) == true
                            ? null
                            : "Password invalid";
                      },
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Confirm Password",
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      textKey: _confirmPasswordKey,
                      obscureText: true,
                      onFieldSubmitted: (val) {
                        _confirmPasswordKey.currentState.validate();
                        _passwordKey.currentState.validate();
                        _loginNameKey.currentState.validate();
                        _emailKey.currentState.validate();
                        _mobileKey.currentState.validate();
                        _surNameKey.currentState.validate();
                        _firstNameKey.currentState.validate();
                      },
                      onChanged: (val) {
                        _confirmPasswordKey.currentState.validate();
                      },
                      validator: (val) {
                        return Validators.isValidConfirmPassword(
                                    val, _passwordController.text) ==
                                true
                            ? null
                            : "Password and Confirm password doesn't match";
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
