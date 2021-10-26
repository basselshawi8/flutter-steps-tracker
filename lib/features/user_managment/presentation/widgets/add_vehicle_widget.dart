import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_behavioral_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_facial_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/create_human_param.dart';
import 'package:micropolis_test/features/user_managment/data/params/get_vehicle_attr_param.dart';
import 'package:micropolis_test/features/user_managment/presentation/bloc/bloc.dart';
import 'package:micropolis_test/features/user_managment/presentation/change_notifiers/user_managment_change_notifier.dart';
import 'package:micropolis_test/features/user_managment/presentation/widgets/ai_configuration_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import 'login_text_field.dart';


bool behavioralAnalysisActive = true;
bool facialActive = true;
bool humanActive = true;

class AddVehicleWidget extends StatefulWidget {
  @override
  _AddVehicleWidgetState createState() {
    return _AddVehicleWidgetState();
  }
}

class _AddVehicleWidgetState extends State<AddVehicleWidget> {


  var imagePerFrameController = TextEditingController();
  var imageBufferSizeController = TextEditingController();

  var frAccuracyController = TextEditingController();
  var frFrameSize = TextEditingController();
  var frProcessFrame = TextEditingController();
  var frCachedFrames = TextEditingController();
  var vsNumberOfFrames = TextEditingController();

  var vehicleIdController = TextEditingController();
  var vehicleNameController = TextEditingController();

  var _isAsync = false;
  var _cancelToken = CancelToken();

  @override
  void initState() {
    BlocProvider.of<UserManagementBloc>(context)
        .add(GetFacial(GetVechileParam(vechileID: vechile_name_id)));
    BlocProvider.of<UserManagementBloc>(context)
        .add(GetBehavioral(GetVechileParam(vechileID: vechile_name_id)));
    BlocProvider.of<UserManagementBloc>(context)
        .add(GetHumanDetection(GetVechileParam(vechileID: vechile_name_id)));

     behavioralAnalysisActive = true;
     facialActive = true;
     humanActive = true;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listenWhen: (prev, current) {
        if (current is CreateHumanDetectionFailureState ||
            current is CreateHumanDetectionSuccessState ||
            current is GetFacialRecognitionSuccessState ||
            current is GetHumanDetectionSuccessState ||
            current is GetBehavioralAnalysisSuccessState ||
            current is CreateBehavioralAnalysisFailureStat ||
            current is CreateBehavioralAnalysisSuccessState ||
            current is CreateFacialRecognitionFailureStat ||
            current is CreateFacialRecognitionSuccessState) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is CreateBehavioralAnalysisFailureStat) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text(state.error.toString()),
              ),
            ),
          ));
        } else if (state is CreateFacialRecognitionFailureStat) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text(state.error.toString()),
              ),
            ),
          ));
        } else if (state is CreateBehavioralAnalysisSuccessState) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text("Behavioral Analysis created"),
              ),
            ),
          ));
          Provider.of<UserManagementChangeNotifier>(context, listen: false)
              .showAddVehicle = false;
          BlocProvider.of<UserManagementBloc>(context)
              .add(GetVehicles(NoParams(cancelToken: _cancelToken)));
        } else if (state is CreateFacialRecognitionSuccessState) {


          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text("Facial Recognition created"),
              ),
            ),
          ));
          Provider.of<UserManagementChangeNotifier>(context, listen: false)
              .showAddVehicle = false;
          BlocProvider.of<UserManagementBloc>(context)
              .add(GetVehicles(NoParams(cancelToken: _cancelToken)));
        } else if (state is CreateHumanDetectionSuccessState) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text(
                    "Human Detection ${humanActive == true ? "Enabled" : "Disabled"}"),
              ),
            ),
          ));
          Provider.of<UserManagementChangeNotifier>(context, listen: false)
              .showAddVehicle = false;
          BlocProvider.of<UserManagementBloc>(context)
              .add(GetVehicles(NoParams(cancelToken: _cancelToken)));
        } else if (state is CreateHumanDetectionFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              height: 40.h,
              child: Center(
                child: Text(state.error.toString()),
              ),
            ),
          ));
        } else if (state is GetFacialRecognitionSuccessState) {
          frProcessFrame.text = "${state.facialModel.data.frProcessFrame}";
          frFrameSize.text = "${state.facialModel.data.frFrameSize}";
          frAccuracyController.text =
              "${state.facialModel.data.frAccuracyValue}";
          frCachedFrames.text = "${state.facialModel.data.frCachedFaces}";
          vsNumberOfFrames.text = "${state.facialModel.data.v}";
          facialActive = state.facialModel.data.frActive;
          vehicleIdController.text =
              state.facialModel.data.vehicleId.vehicleCode;
          vehicleNameController.text =
              state.facialModel.data.vehicleId.vehicleId;
        } else if (state is GetBehavioralAnalysisSuccessState) {
          imagePerFrameController.text =
              "${state.behavioralModel.data.baImagesPerFile}";
          imageBufferSizeController.text =
              "${state.behavioralModel.data.baImgSize}";
          behavioralAnalysisActive = state.behavioralModel.data.baActive;
        } else if (state is GetHumanDetectionSuccessState) {
          humanActive = state.humanDetectionModel.data.hd == 1 ? true : false;
        }
        setState(() {
          _isAsync = false;
        });
      },
      child: ModalProgressHUD(
        inAsyncCall: _isAsync,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 80.h, horizontal: 560.w),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          "Rover",
                          style: TextStyle(
                              color: CoreStyle.operationTextGrayColor,
                              fontSize: 17.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          "AI Configurations",
                          style: TextStyle(
                              color: CoreStyle.operationTextGrayColor,
                              fontSize: 15.sp,
                              fontFamily:
                                  CoreStyle.fontWithWeight(FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<UserManagementChangeNotifier>(context,
                              listen: false)
                          .showAddVehicle = false;
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
              _buildVehicleDetails(),
              SizedBox(
                height: 8.h,
              ),
              _buildVehicleDetailsTextField(),
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
              _buildFaceRecognitionAttributes(),
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
              _buildBehavioralAnalysisAttributes(),
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
              _buildHumanDetectionAttributes(),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isAsync = true;
                      });

                      if (imagePerFrameController.text.isNotEmpty ||
                          imageBufferSizeController.text.isNotEmpty) {
                        BlocProvider.of<UserManagementBloc>(context).add(
                            CreateBehavioralAnalysis(CreateBehavioralParam(
                                ba_active: behavioralAnalysisActive,
                                vehicle_id: vechile_id,
                                ba_img_size: int.tryParse(
                                    imageBufferSizeController.text),
                                ba_images_per_file: int.tryParse(
                                    imagePerFrameController.text))));
                      }
                      if (frCachedFrames.text.isNotEmpty ||
                          frProcessFrame.text.isNotEmpty ||
                          frFrameSize.text.isNotEmpty ||
                          frAccuracyController.text.isNotEmpty ||
                          vsNumberOfFrames.text.isNotEmpty) {
                        BlocProvider.of<UserManagementBloc>(context).add(
                            CreateFacialRecognition(CreateFacialParam(
                                fr_cached_faces:
                                    int.tryParse(frCachedFrames.text),
                                fr_accuracy_value:
                                    int.tryParse(frAccuracyController.text),
                                fr_active: facialActive,
                                fr_frame_size:
                                    double.tryParse(frFrameSize.text),
                                vs_number_of_frames:
                                    int.tryParse(vsNumberOfFrames.text),
                                vehicle_id: vechile_id,
                                fr_process_frame:
                                    int.tryParse(frProcessFrame.text))));
                      }
                      BlocProvider.of<UserManagementBloc>(context).add(
                          CreateHumanDetection(CreateHumanDetectionParam(
                              vechileID: vechile_id, hd: humanActive)));
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
                height: 16.h,
              )
            ]),
          ),
        ),
      ),
    );
  }

  _buildHumanDetectionAttributes() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Humen Detection Attributes",
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
            CupertinoSwitch(
                value: humanActive,
                onChanged: (val) {
                  setState(() {
                    humanActive = val;
                  });
                }),
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
                      helperText: "Attribute 1",
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Attribute 2",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  _buildBehavioralAnalysisAttributes() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Behavioral Analysis Attributes",
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
            CupertinoSwitch(
                value: behavioralAnalysisActive,
                onChanged: (val) {
                  setState(() {
                    behavioralAnalysisActive = val;
                  });
                }),
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
                      helperText: "Image Size",
                      height: 40.h,
                      controller: imageBufferSizeController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      controller: imagePerFrameController,
                      textInputAction: TextInputAction.done,
                      helperText: "Image Per File",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  _buildFaceRecognitionAttributes() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Face Recognition Attributes",
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
            CupertinoSwitch(
                value: facialActive,
                onChanged: (val) {
                  setState(() {
                    facialActive = val;
                  });
                }),
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
                      helperText: "Accuracy",
                      controller: frAccuracyController,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      helperText: "Frame Size",
                      controller: frFrameSize,
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
                      helperText: "Process Frame",
                      controller: frProcessFrame,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.45,
                    child: LoginTextField(
                      height: 40.h,
                      controller: frCachedFrames,
                      helperText: "Cached Faces Timer",
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
                      helperText: "Number of Frames",
                      controller: vsNumberOfFrames,
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

  _buildVehicleDetailsTextField() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: constraints.maxWidth * 0.45,
                child: LoginTextField(
                  helperText: "No.",
                  controller: vehicleIdController,
                  height: 40.h,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.45,
                child: LoginTextField(
                  height: 40.h,
                  controller: vehicleNameController,
                  helperText: "Name",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildVehicleDetails() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Vehicle Details",
                style: TextStyle(
                    color: CoreStyle.operationTextGrayColor,
                    fontSize: 17.sp,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w700)),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "About this Vehicle",
                style: TextStyle(
                    color: CoreStyle.operationTextGrayColor,
                    fontSize: 15.sp,
                    fontFamily: CoreStyle.fontWithWeight(FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
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
    );
  }
}
