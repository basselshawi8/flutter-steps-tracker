import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/PedoMeterUtil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/features/home/data/params/add_step_param.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_event.dart';

import '../../../../../core/ui/waiting_widget.dart';
import '../../../../../service_locator.dart';
import '../../../data/model/steps_model.dart';
import '../../bloc/steps_bloc.dart';
import '../../bloc/steps_state.dart';

class StepsScreen extends StatefulWidget {
  @override
  _StepsScreenState createState() {
    return _StepsScreenState();
  }
}

class _StepsScreenState extends State<StepsScreen> {

  var _getStepsBloc = StepsBloc();

  @override
  void initState() {
    _callApis();
    super.initState();
  }

  _callApis() async {
    _getStepsBloc.add(GetUserSteps(
        GetUserStepsParam(deviceId: appConfig.deviceUniqueIdentifier!)));
  }

  @override
  void dispose() {
    _getStepsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreStyle.tchpinBlack,
      body: BlocListener<StepsBloc, StepsState>(
        listener: (contex, state) {
          if (state is AddUserStepSuccessState) {
            _callApis();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<StepsModel>(
                stream: locator<PedoMeterUtil>().numberOfStepsStream,
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      'Number of Steps this Session:\n $totalSteps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: TchipinFontWeight.medium,
                          fontSize: 22.sp,
                          color: CoreStyle.white,
                          fontFamily: 'Roboto'),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder(
                builder: (context, state) {
                  if (state is GetUserStepsSuccessState) {
                    var allSteps = 0;
                    for (var step in state.steps) {
                      allSteps += step.steps;
                    }
                    return Text(
                      'All Steps Taken Since you started:\n $allSteps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: TchipinFontWeight.medium,
                          fontSize: 22.sp,
                          color: CoreStyle.white,
                          fontFamily: 'Roboto'),
                    );
                  } else if(state is GetUserStepsWaitingState) {
                    return WaitingWidget();
                  }else {
                    return Container();
                  }
                },
                bloc: _getStepsBloc,
              )
            ],
          ),
        ),
      ),
    );
  }
}
