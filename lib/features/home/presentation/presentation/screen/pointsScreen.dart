import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/waiting_widget.dart';
import 'package:micropolis_test/features/home/data/params/get_user_steps_param.dart';
import 'package:micropolis_test/features/home/domain/entity/health_point_entity.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_bloc.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_event.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_state.dart';
import 'package:intl/intl.dart';

class PointsScreen extends StatefulWidget {
  @override
  _PointsScreenState createState() {
    return _PointsScreenState();
  }
}

class _PointsScreenState extends State<PointsScreen> {
  List<HealthPointEntity> points = [];

  @override
  void initState() {
    BlocProvider.of<StepsBloc>(context).add(GetUserHealthPoints(
        GetUserStepsParam(deviceId: appConfig.deviceUniqueIdentifier!)));
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
              BlocConsumer<StepsBloc, StepsState>(
                listener: (context, state) {
                  if (state is AddHealthPointSuccessState) {
                    BlocProvider.of<StepsBloc>(context).add(GetUserHealthPoints(
                        GetUserStepsParam(
                            deviceId: appConfig.deviceUniqueIdentifier!)));
                  }
                },
                builder: (context, state) {
                  if (state is GetHealthPointSuccessState) {
                    points = state.points;

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });
                    var notUsedHealthPoints = 0;
                    for (var point in state.points) {
                      if (point.used == false) {
                        notUsedHealthPoints += 1;
                      }
                    }
                    return Text(
                      'Number of Valid Health Points:\n $notUsedHealthPoints',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: TchipinFontWeight.medium,
                          fontSize: 22.sp,
                          color: CoreStyle.white,
                          fontFamily: 'Roboto'),
                    );
                  } else if (state is GetHealthPointWaitingState) {
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
              Row(
                children: [
                  Text('Points',
                      style: TextStyle(
                          fontWeight: TchipinFontWeight.medium,
                          fontSize: 17.sp,
                          color: CoreStyle.white,
                          fontFamily: 'Roboto')),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
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
                              Text(
                                  'Date: ${DateFormat('yyyy/MM/dd hh:mm').format(points[index].date!)}',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  'Is Valid: ${points[index].used == true ? 'No' : 'Yes'}',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto'))
                            ],
                          ),
                        );
                      },
                      itemCount: points.length))
            ],
          ),
        ),
      ),
    );
  }
}
