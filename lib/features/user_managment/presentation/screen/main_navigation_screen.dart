import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/constants.dart';
import 'package:micropolis_test/features/camera/presentation/screens/main_window_screen.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/add_vehicle_widget.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/ai_configuration_widget.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/criminal_login_widget.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/users_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

enum ManagementPage { Dashboard, CriminalLogic, AIConfigurations, Users }

BehaviorSubject<ManagementPage> managementPageIndex =
    BehaviorSubject<ManagementPage>();

class MainNavigationPage extends StatefulWidget {
  static const routeName = '/mainNavigationScreen';

  @override
  _MainNavigationPageState createState() {
    managementPageIndex.add(ManagementPage.CriminalLogic);

    return _MainNavigationPageState();
  }
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  @override
  void initState() {
    managementPageIndex.listen((value) {
      if (value == ManagementPage.Dashboard) {
        Navigator.of(context).pushNamed(MainWindowScreen.routeName);
      } else {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserManagementChangeNotifier>(
        builder: (context, state, _) {
          return Stack(
            children: [
              Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 400.w,
                    height: double.maxFinite,
                    color: CoreStyle.operationIncidentListBlackColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          IMG_POLICE_LOGO,
                          width: 100.w,
                          height: 100.w,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        InkWell(
                          onTap: () {
                            managementPageIndex.add(ManagementPage.Dashboard);
                          },
                          child: Container(
                            height: 45.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: managementPageIndex.value ==
                                    ManagementPage.Dashboard
                                ? BoxDecoration(
                                    color: CoreStyle.operationButtonGreenColor,
                                    borderRadius: BorderRadius.circular(8.r))
                                : null,
                            child: Text(
                              "Dashboard",
                              style: managementPageIndex.value ==
                                      ManagementPage.Dashboard
                                  ? TextStyle(
                                      color: CoreStyle.white,
                                      fontSize: 16.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w300))
                                  : TextStyle(
                                      color:
                                          CoreStyle.operationLightGreyTextColor,
                                      fontSize: 17.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            managementPageIndex
                                .add(ManagementPage.CriminalLogic);
                          },
                          child: Container(
                            height: 45.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: managementPageIndex.value ==
                                    ManagementPage.CriminalLogic
                                ? BoxDecoration(
                                    color: CoreStyle.operationButtonGreenColor,
                                    borderRadius: BorderRadius.circular(8.r))
                                : null,
                            child: Text(
                              "Criminal Logic",
                              style: managementPageIndex.value ==
                                      ManagementPage.CriminalLogic
                                  ? TextStyle(
                                      color: CoreStyle.white,
                                      fontSize: 16.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w300))
                                  : TextStyle(
                                      color:
                                          CoreStyle.operationLightGreyTextColor,
                                      fontSize: 17.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            managementPageIndex
                                .add(ManagementPage.AIConfigurations);
                          },
                          child: Container(
                            height: 45.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: managementPageIndex.value ==
                                    ManagementPage.AIConfigurations
                                ? BoxDecoration(
                                    color: CoreStyle.operationButtonGreenColor,
                                    borderRadius: BorderRadius.circular(8.r))
                                : null,
                            child: Text(
                              "AI Configurations",
                              style: managementPageIndex.value ==
                                      ManagementPage.AIConfigurations
                                  ? TextStyle(
                                      color: CoreStyle.white,
                                      fontSize: 16.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w300))
                                  : TextStyle(
                                      color:
                                          CoreStyle.operationLightGreyTextColor,
                                      fontSize: 17.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            managementPageIndex.add(ManagementPage.Users);
                          },
                          child: Container(
                            height: 45.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: managementPageIndex.value ==
                                    ManagementPage.Users
                                ? BoxDecoration(
                                    color: CoreStyle.operationButtonGreenColor,
                                    borderRadius: BorderRadius.circular(8.r))
                                : null,
                            child: Text(
                              "Users",
                              style: managementPageIndex.value ==
                                      ManagementPage.Users
                                  ? TextStyle(
                                      color: CoreStyle.white,
                                      fontSize: 16.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w300))
                                  : TextStyle(
                                      color:
                                          CoreStyle.operationLightGreyTextColor,
                                      fontSize: 17.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Positioned(
                  left: 400.w,
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        color: CoreStyle.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Hi,",
                              style: TextStyle(
                                  color: CoreStyle.operationDarkTextColor
                                      .withOpacity(0.6),
                                  fontSize: 14.sp,
                                  fontFamily: CoreStyle.fontWithWeight(
                                      FontWeight.w400)),
                            ),
                            SizedBox(width: 2.w),
                            Text("CEO",
                                style: TextStyle(
                                    color: CoreStyle.operationGrayTextColor,
                                    fontSize: 14.sp,
                                    fontFamily: CoreStyle.fontWithWeight(
                                        FontWeight.w600))),
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                  color: CoreStyle.operationLittleBoxColor,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                  child: Text("C",
                                      style: TextStyle(
                                          color:
                                              CoreStyle.operationGrayTextColor,
                                          fontSize: 16.sp,
                                          fontFamily: CoreStyle.fontWithWeight(
                                              FontWeight.w600)))),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1.5.h,
                        color: CoreStyle.operationBlackColor.withOpacity(0.1),
                      ),
                      Expanded(
                          child: managementPageIndex.value ==
                                  ManagementPage.CriminalLogic
                              ? CriminalLogicWidget()
                              : managementPageIndex.value ==
                                      ManagementPage.AIConfigurations
                                  ? AIConfigurationWidget()
                                  : managementPageIndex.value ==
                                          ManagementPage.Users
                                      ? UsersWidget()
                                      : Container())
                    ],
                  )),
              if (state.showAddVehicle == true)
                Positioned.fill(
                    child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: CoreStyle.operationBlack2Color.withOpacity(0.4),
                  child: AddVehicleWidget(),
                ))
            ],
          );
        },
      ),
    );
  }
}
