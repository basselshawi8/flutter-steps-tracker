import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/core/ui/custom_text_field.dart';
import 'package:micropolis_test/features/map/data/params/add_polygon_param.dart';
import 'package:micropolis_test/features/map/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/map/presentation/screen/polygon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

extension editPolygonDetailsExtension on PolygonDrawerState {
  editPolygonDetails() {
    return ModalProgressHUD(
      inAsyncCall: isAsync,
      child: BlocListener<MapBloc, MapState>(
        listenWhen: (prev, current) {
          if (current is CreatePolygonSuccessState ||
              current is CreatePolygonWaitingState ||
              current is CreatePolygonFailureState) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state is CreatePolygonSuccessState) {
            polygonNameController.text = "";
            showEditPolygonDetails = false;
            isAsync = false;
            BlocProvider.of<MapBloc>(context)
                .add(GetPolygons(NoParams(cancelToken: cancelToken)));
            refresh();
          } else if (state is CreatePolygonFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                    height: 40.h,
                    child: Center(child: Text(state.error.toString())))));
            isAsync = false;
            refresh();
          }
        },
        child: Positioned(
            left: 460.w,
            top: 190.h,
            child: Container(
              width: 1000.w,
              height: 700.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: CoreStyle.operationBlack2Color,
                  borderRadius: BorderRadius.circular(12.r)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            polygonNameController.text = "";
                            showEditPolygonDetails = false;
                            refresh();
                          },
                          child: Icon(
                            Icons.close,
                            size: 40.w,
                            color: CoreStyle.white,
                          ),
                        ),
                        Text(
                          "Edit Polygon Details",
                          style: TextStyle(
                              color: CoreStyle.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 28.sp),
                        ),
                        Container(
                          width: 10.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: CustomTextField(
                        helperText: "Polygon name",
                        textInputAction: TextInputAction.done,
                        focusNode: polygonNameFocusNode,
                        textKey: polygonNameKey,
                        controller: polygonNameController,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            selectedCountries.add(country);
                            refresh();
                          },
                        );
                      },
                      child: Container(
                        width: 160.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: CoreStyle.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Center(
                          child: Text(
                            "Add Country",
                            style: TextStyle(
                                color: CoreStyle.operationBlack2Color,
                                fontWeight: FontWeight.w400,
                                fontSize: 26.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 40.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            decoration: BoxDecoration(
                                color: CoreStyle.white,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.close,
                                    color: CoreStyle.operationBlack2Color,
                                  ),
                                  onTap: () {
                                    selectedCountries.removeAt(index);
                                    refresh();
                                  },
                                ),
                                Text(
                                  selectedCountries[index].name,
                                  style: TextStyle(
                                    color: CoreStyle.operationBlack2Color,
                                    fontSize: 19.sp,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedCountries.length,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Severity Weight",
                            style: TextStyle(
                                color: CoreStyle.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600),
                          )),
                          DropdownButton<String>(
                            value: severityValue,
                            items: <String>['1', '2', '3', '4']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: CoreStyle.operationRedColor,
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (_value) {
                              severityValue = _value;
                              refresh();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Selected Days",
                            style: TextStyle(
                                color: CoreStyle.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          DropdownButton<String>(
                            value: selectedDay,
                            items: <String>[
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: CoreStyle.operationGreenContent,
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (_value) {
                              selectedDay = _value;
                              refresh();
                            },
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context, "from");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CoreStyle.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "From",
                                  style: TextStyle(
                                      color: CoreStyle.operationBlack2Color,
                                      fontSize: 19.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context, "to");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CoreStyle.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                      color: CoreStyle.operationBlack2Color,
                                      fontSize: 19.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            "Flag Suspect",
                            style: TextStyle(
                                color: CoreStyle.white, fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Checkbox(
                              value: flagSuspect,
                              onChanged: (_val) {
                                flagSuspect = _val;
                                refresh();
                              }),
                          SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              selectedDays.add(CriticalTime(
                                  from, to, selectedDay, flagSuspect));
                              refresh();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CoreStyle.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: CoreStyle.operationBlack2Color,
                                      fontSize: 19.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            decoration: BoxDecoration(
                                color: CoreStyle.white,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.close,
                                    color: CoreStyle.operationBlack2Color,
                                  ),
                                  onTap: () {
                                    selectedDays.removeAt(index);
                                    refresh();
                                  },
                                ),
                                Text(
                                  "${selectedDays[index].day} ${selectedDays[index].from.hour} ${selectedDays[index].to.hour}",
                                  style: TextStyle(
                                    color: CoreStyle.operationBlack2Color,
                                    fontSize: 19.sp,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedDays.length,
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    InkWell(
                      onTap: () {
                        isAsync = true;
                        var key = polygonLocations?.keys?.last ?? "1";

                        BlocProvider.of<MapBloc>(context).add(CreatePolygon(
                            AddPolygonParam(
                                points: polygonLocations[key],
                                weight: int.tryParse(severityValue),
                                nationality: selectedCountries
                                    .map((e) => e.countryCode)
                                    .toList(),
                                days: selectedDays,
                                name: polygonNameController.text,
                                cancelToken: cancelToken)));

                        refresh();
                      },
                      child: Container(
                        width: 180.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: CoreStyle.white.withOpacity(0.8)),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: CoreStyle.operationBlackColor,
                                fontSize: 22.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context, String type) async {
    final TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay(hour: 12, minute: 0),
      context: context,
    );
    if (picked != null) if (type == "from") {
      from = picked;
    } else {
      to = picked;
    }
    refresh();
  }
}
