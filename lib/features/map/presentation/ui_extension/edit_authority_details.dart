import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/ui/custom_text_field.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/features/map/data/params/add_authority_param.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';
import 'package:micropolis_test/features/map/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/login_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

extension editAuthorityDetailsExtension on PolygonDrawerState {
  editAuthorityDetails() {
    return ModalProgressHUD(
      inAsyncCall: isAsync,
      child: BlocListener<MapBloc, MapState>(
        listenWhen: (prev, current) {
          if (current is CreateAuthorityAreaSuccessState ||
              current is CreateAuthorityAreaFailureState) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state is CreateAuthorityAreaSuccessState) {
            polygonNameController.text = "";
            showEditAuthorityDetails = false;
            isAsync = false;
            BlocProvider.of<MapBloc>(context)
                .add(GetAuthorityAreas(NoParams(cancelToken: cancelToken)));
            refresh();
          } else if (state is CreateAuthorityAreaFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                    height: 40.h,
                    child: Center(child: Text(state.error.toString())))));
            isAsync = false;
            refresh();
          }
        },
        child: Positioned(
            left: 260.w,
            top: 190.h,
            child: Container(
              width: 700.w,
              height: 500.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: CoreStyle.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            "Authority Details",
                            style: TextStyle(
                                color: CoreStyle.operationTextGrayColor,
                                fontSize: 17.sp,
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w700)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            polygonNameController.text = "";
                            showEditAuthorityDetails = false;
                            refresh();
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.45,
                                  child: LoginTextField(
                                    helperText: "Area Name",
                                    textInputAction: TextInputAction.done,
                                    focusNode: polygonNameFocusNode,
                                    textKey: polygonNameKey,
                                    controller: polygonNameController,
                                    height: 40.h,
                                  ),
                                ),
                                Container(
                                  width: constraints.maxWidth * 0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Police Department",
                                        style: TextStyle(
                                            color: CoreStyle
                                                .operationTextBlueColor,
                                            fontSize: 15.sp,
                                            fontFamily:
                                                CoreStyle.fontWithWeight(
                                                    FontWeight.w400)),
                                      ),
                                      BlocBuilder<MapBloc, MapState>(
                                        buildWhen: (context, state) {
                                          if (state is GetPoliceDepartmentsWaitingState ||
                                              state
                                                  is GetPoliceDepartmentsSuccessState ||
                                              state
                                                  is GetPoliceDepartmentsFailureState) {
                                            return true;
                                          } else {
                                            return false;
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state
                                              is GetPoliceDepartmentsWaitingState) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (state
                                              is GetPoliceDepartmentsFailureState) {
                                            return ErrorScreenWidget(
                                              state: state,
                                            );
                                          } else if (state
                                              is GetPoliceDepartmentsSuccessState) {
                                            policeDepartments = state
                                                .policeDepartmentModel.data;
                                            policeDepartment =
                                                policeDepartment == null
                                                    ? state
                                                        ?.policeDepartmentModel
                                                        ?.data
                                                        ?.first
                                                        ?.name
                                                    : policeDepartment;
                                            return DropdownButton<String>(
                                              value: policeDepartment,
                                              items: state
                                                  .policeDepartmentModel.data
                                                  .map((e) => e.name)
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        color: CoreStyle
                                                            .operationGrayTextColor,
                                                        fontSize: 23.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (_value) {
                                                policeDepartment = _value;
                                                refresh();
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            isAsync = true;
                            var key = polygonLocations?.keys?.last ?? "1";

                            BlocProvider.of<MapBloc>(context).add(
                                CreateAuthorityArea(AddAuthorityParam(
                                    points: polygonLocations[key].points,
                                    title: polygonNameController.text,
                                    policeDepartment: policeDepartments
                                        .firstWhere(
                                            (element) =>
                                                element.name ==
                                                policeDepartment,
                                            orElse: () => null)
                                        ?.id,
                                    cancelToken: cancelToken)));

                            refresh();
                          },
                          child: Container(
                            width: 120.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                                color: CoreStyle.operationButtonGreenColor,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: CoreStyle.white,
                                    fontFamily: CoreStyle.fontWithWeight(
                                        FontWeight.w500),
                                    fontSize: 17.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
