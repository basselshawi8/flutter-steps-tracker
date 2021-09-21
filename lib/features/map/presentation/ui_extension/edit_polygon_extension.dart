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
import 'package:micropolis_test/features/user_managment/presentation/widgets/login_text_field.dart';
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
                            "Area Details",
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
                            showEditPolygonDetails = false;
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
                                        "Severity Weight",
                                        style: TextStyle(
                                            color: CoreStyle
                                                .operationTextBlueColor,
                                            fontSize: 15.sp,
                                            fontFamily:
                                                CoreStyle.fontWithWeight(
                                                    FontWeight.w400)),
                                      ),
                                      DropdownButton<String>(
                                        value: severityValue,
                                        items: <String>['1', '2', '3', '4']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: CoreStyle
                                                      .operationGrayTextColor,
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
                              ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Suspects Nationality",
                            style: TextStyle(
                                color: CoreStyle.operationTextBlueColor,
                                fontSize: 15.sp,
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 8.h,
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
                              height: 50.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                      color: CoreStyle.operationBlack2Color
                                          .withOpacity(0.2),
                                      width: 1.w)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 4.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w),
                                          decoration: BoxDecoration(
                                              color: CoreStyle
                                                  .operationGrayBoxColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text(
                                                selectedCountries[index].name,
                                                style: TextStyle(
                                                    color: CoreStyle
                                                        .operationTextGrayColor,
                                                    fontSize: 16.sp,
                                                    fontFamily: CoreStyle
                                                        .fontWithWeight(
                                                            FontWeight.w600)),
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              InkWell(
                                                child: Icon(
                                                  Icons.close,
                                                  size: 25.w,
                                                  color: CoreStyle
                                                      .operationTextGrayColor,
                                                ),
                                                onTap: () {
                                                  selectedCountries
                                                      .removeAt(index);
                                                  refresh();
                                                },
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
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
                                    width: 4.w,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 25.w,
                                    color: CoreStyle.operationGrayTextColor,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: Color(0xFFFCFCFC),
                          border: Border.all(
                              color: CoreStyle.operationBlack2Color
                                  .withOpacity(0.2),
                              width: 1.w)),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select Days",
                            style: TextStyle(
                                color: Color(0xFF7E7E7E),
                                fontSize: 16.sp,
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
                                      color: CoreStyle
                                          .operationIncidentActionColor,
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
                                  color: CoreStyle.white,
                                  border: Border.all(
                                      color: CoreStyle.operationBlack2Color
                                          .withOpacity(0.2),
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "From",
                                  style: TextStyle(
                                      color: CoreStyle
                                          .operationIncidentActionColor,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400),
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
                                  color: CoreStyle.white,
                                  border: Border.all(
                                      color: CoreStyle.operationBlack2Color
                                          .withOpacity(0.2),
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                      color: CoreStyle
                                          .operationIncidentActionColor,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400),
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
                                color: CoreStyle.operationIncidentActionColor,
                                fontSize: 16.sp,
                                fontFamily:
                                    CoreStyle.fontWithWeight(FontWeight.w400)),
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
                                  color: CoreStyle.operationButtonGreenColor,
                                  borderRadius: BorderRadius.circular(8.r)),
                              width: 80.w,
                              height: 30.h,
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: CoreStyle.white,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w300),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ),
                          )
                        ],
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
                                color: CoreStyle.operationLittleBoxColor,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "${selectedDays[index].day} ${selectedDays[index].from.hour}:${selectedDays[index].from.minute} - ${selectedDays[index].to.hour}:${selectedDays[index].to.hour}",
                                  style: TextStyle(
                                      color: CoreStyle.operationTextGrayColor,
                                      fontSize: 17.sp,
                                      fontFamily: CoreStyle.fontWithWeight(
                                          FontWeight.w400)),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.close,
                                    color: CoreStyle.operationTextGrayColor,
                                    size: 25.w,
                                  ),
                                  onTap: () {
                                    selectedDays.removeAt(index);
                                    refresh();
                                  },
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
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
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
