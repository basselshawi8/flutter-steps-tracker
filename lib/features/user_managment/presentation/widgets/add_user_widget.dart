import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:provider/provider.dart';

import 'login_text_field.dart';

class AddUserWidget extends StatefulWidget {
  @override
  _AddUserWidgetState createState() {
    return _AddUserWidgetState();
  }
}

class _AddUserWidgetState extends State<AddUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 260.h, horizontal: 560.w),
      decoration: BoxDecoration(
          color: CoreStyle.white, borderRadius: BorderRadius.circular(12.r)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      fontFamily: CoreStyle.fontWithWeight(FontWeight.w700)),
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
                  Provider.of<UserManagementChangeNotifier>(context,
                          listen: false)
                      .showAddUser = false;
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
          )
        ]),
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
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Sur Name",
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
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Mobile",
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
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Roles",
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
                      helperText: "Password",
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Confirm Password",
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
