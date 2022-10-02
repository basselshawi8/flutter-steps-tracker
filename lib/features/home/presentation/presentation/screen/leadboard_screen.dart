import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/home/domain/entity/steps_entity.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_event.dart';

import '../../../../../core/ui/waiting_widget.dart';
import '../../bloc/steps_bloc.dart';
import '../../bloc/steps_state.dart';

class LeadBoardScreen extends StatefulWidget {
  @override
  _LeadBoardScreenState createState() {
    return _LeadBoardScreenState();
  }
}

class _LeadBoardScreenState extends State<LeadBoardScreen> {
  Map<String, int> result = {};

  @override
  void initState() {
    BlocProvider.of<StepsBloc>(context).add(GetSteps(NoParams()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreStyle.tchpinBlack,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              BlocBuilder<StepsBloc, StepsState>(
                builder: (context, state) {
                  if (state is GetStepsSuccessState) {
                    result = groupBy(state.steps, (StepsEntity e) {
                      return e.name;
                    }).map((key, value) => MapEntry(
                        key,
                        value
                            .map((e) => e.steps)
                            .reduce((value, element) => value + element)));

                    result = Map.fromEntries(result.entries.toList()
                      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });
                    return Text(
                      'LeadBoard Results',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: TchipinFontWeight.medium,
                          fontSize: 22.sp,
                          color: CoreStyle.white,
                          fontFamily: 'Roboto'),
                    );
                  } else if (state is GetStepsWaitingState) {
                    return Container(
                        width: double.maxFinite, child: WaitingWidget());
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var name = result.keys.toList()[index];
                        var totalSteps = result[name];
                        return Container(
                          height: 80.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CoreStyle.white, width: 1.r),
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: $name',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text('Steps: $totalSteps',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto'))
                            ],
                          ),
                        );
                      },
                      itemCount: result.keys.length))
            ],
          ),
        ),
      ),
    );
  }
}
