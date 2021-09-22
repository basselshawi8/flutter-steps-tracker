import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';
import 'package:micropolis_test/features/user_managment/data/models/create_user_model.dart';
import 'package:micropolis_test/features/user_managment/data/models/users_list_model.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/usermanagement_bloc.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/usermanagement_event.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:provider/provider.dart';

class UsersWidget extends StatefulWidget {
  @override
  _UsersWidgetState createState() {
    return _UsersWidgetState();
  }
}

class _UsersWidgetState extends State<UsersWidget> {
  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    BlocProvider.of<UserManagementBloc>(context)
        .add(GetUsers(NoParams(cancelToken: _cancelToken)));

    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoreStyle.operationGrayBackgroundColor,
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: double.maxFinite,
            color: CoreStyle.white,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Users",
                  style: TextStyle(
                      color: CoreStyle.operationBlackTextColor,
                      fontFamily: CoreStyle.fontWithWeight(FontWeight.w600),
                      fontSize: 21.sp),
                ),
                InkWell(
                  child: Container(
                    height: 35.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        color: CoreStyle.operationButtonGreenColor,
                        borderRadius: BorderRadius.circular(7.r)),
                    child: Center(
                      child: Text(
                        "+ New User",
                        style: TextStyle(
                            color: CoreStyle.white,
                            fontSize: 15.sp,
                            fontFamily:
                                CoreStyle.fontWithWeight(FontWeight.w300)),
                      ),
                    ),
                  ),
                  onTap: () {
                    Provider.of<UserManagementChangeNotifier>(context,
                            listen: false)
                        .showAddUser = true;
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: CoreStyle.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: CoreStyle.bottomBarTextBackGroundColor
                          .withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 6,
                    )
                  ]),
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 120.w, vertical: 80.h),
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      "Users",
                      style: TextStyle(
                          color: CoreStyle.operationTextGrayColor,
                          fontSize: 17.sp,
                          fontFamily:
                              CoreStyle.fontWithWeight(FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      "Define your users and roles",
                      style: TextStyle(
                          color: CoreStyle.operationTextGrayColor,
                          fontSize: 15.sp,
                          fontFamily:
                              CoreStyle.fontWithWeight(FontWeight.w300)),
                    ),
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
                  BlocBuilder<UserManagementBloc, UserManagementState>(
                    buildWhen: (prev, current) {
                      if (current is GetUsersWaitingState ||
                          current is GetUsersSuccessState ||
                          current is GetUsersFailureState) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      if (state is GetUsersWaitingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetUsersFailureState) {
                        return ErrorScreenWidget(
                          error: state.error,
                          state: state,
                        );
                      } else if (state is GetUsersSuccessState) {
                        return _buildContent(state.users);
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildContent(UsersListModel users) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          } else {
            return _buildCell(users.data[index - 1]);
          }
        },
        shrinkWrap: true,
        itemCount: users.data.length + 1,
      ),
    );
  }

  _buildHeader() {
    return Column(
      children: [
        Container(
          height: 60.h,
          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 12.h),
          child: Row(
            children: [
              Container(
                  width: 200.w,
                  child: Text(
                    "Login Name",
                    style: TextStyle(
                        color:
                            CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                  )),
              Container(
                  width: 170.w,
                  child: Text(
                    "First Name",
                    style: TextStyle(
                        color:
                            CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                  )),
              Container(
                  width: 170.w,
                  child: Text(
                    "Sur-name",
                    style: TextStyle(
                        color:
                            CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                  )),
              Container(
                  width: 250.w,
                  child: Text(
                    "Mobile",
                    style: TextStyle(
                        color:
                            CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                  )),
              Container(
                  width: 200.w,
                  child: Text(
                    "Roles",
                    style: TextStyle(
                        color:
                            CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                  )),
              Expanded(
                child: SizedBox(
                  width: 10.w,
                ),
              ),
              Transform.translate(
                offset: Offset(-32.w, 0),
                child: Text(
                  "Active",
                  style: TextStyle(
                      color:
                          CoreStyle.operationTextGrayColor.withOpacity(0.48)),
                ),
              ),
              SizedBox(
                width: 122.w,
              ),
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 1.h,
          color: CoreStyle.operationBlack2Color.withOpacity(0.1),
        )
      ],
    );
  }

  _buildCell(UserData user) {
    return Column(
      children: [
        Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              Container(
                  width: 200.w,
                  child: Text(
                    user?.username ?? "user_1",
                    style: TextStyle(color: CoreStyle.operationTextGrayColor),
                  )),
              Container(
                  width: 170.w,
                  child: Text(
                    user.name,
                    style: TextStyle(color: CoreStyle.operationTextGrayColor),
                  )),
              Container(
                  width: 170.w,
                  child: Text(
                    user.surname,
                    style: TextStyle(color: CoreStyle.operationTextGrayColor),
                  )),
              Container(
                  width: 250.w,
                  child: Text(
                    "+963933671555",
                    style: TextStyle(color: CoreStyle.operationTextGrayColor),
                  )),
              Container(
                  width: 200.w,
                  child: Text(
                    user.role.length > 0 == true ? user.role.first : "",
                    style: TextStyle(color: CoreStyle.operationTextGrayColor),
                  )),
              Expanded(
                child: SizedBox(
                  width: 10.w,
                ),
              ),
              CupertinoSwitch(value: true, onChanged: (val) {}),
              SizedBox(
                width: 80.w,
              ),
              InkWell(
                child: Icon(
                  Icons.more_vert,
                  size: 30.w,
                  color: CoreStyle.operationTextGrayColor.withOpacity(0.48),
                ),
              ),
              SizedBox(
                width: 12,
              )
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 1.h,
          color: CoreStyle.operationBlack2Color.withOpacity(0.1),
        )
      ],
    );
  }
}
