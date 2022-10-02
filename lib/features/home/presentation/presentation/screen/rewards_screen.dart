import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/tchipin_button.dart';
import 'package:micropolis_test/core/utils.dart';
import 'package:micropolis_test/features/home/data/model/my_reward_model.dart';
import 'package:micropolis_test/features/home/data/params/add_reward_param.dart';
import 'package:micropolis_test/features/home/domain/entity/my_reward_entity.dart';
import 'package:micropolis_test/features/home/domain/entity/reward_entity.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/ui/waiting_widget.dart';
import '../../../../../service_locator.dart';
import '../../../data/params/get_user_steps_param.dart';
import '../../../domain/repository/isteps_repository.dart';
import '../../bloc/steps_bloc.dart';
import '../../bloc/steps_event.dart';
import '../../bloc/steps_state.dart';
import 'package:intl/intl.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() {
    return _RewardsScreenState();
  }
}

class _RewardsScreenState extends State<RewardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var notUsedHealthPoints = 0;
  var isAsync = false;
  List<MyRewardEntity> myRewards = [];

  List<RewardEntity> rewards = [
    RewardEntity(name: 'StarBucks Coffee', price: 1),
    RewardEntity(name: 'Apple Watch', price: 2)
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<StepsBloc>(context).add(GetUserHealthPoints(
        GetUserStepsParam(deviceId: appConfig.deviceUniqueIdentifier!)));

    _tabController.addListener(() {
      if (_tabController.index == 1) {
        BlocProvider.of<StepsBloc>(context).add(GetMyRewards(
            GetUserStepsParam(deviceId: appConfig.deviceUniqueIdentifier!)));
      }
    });

    isAsync = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Text(
              'All Rewards',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: TchipinFontWeight.medium,
                  fontSize: 22.sp,
                  color: CoreStyle.white,
                  fontFamily: 'Roboto'),
            ),
            Text(
              'My Rewards',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: TchipinFontWeight.medium,
                  fontSize: 22.sp,
                  color: CoreStyle.white,
                  fontFamily: 'Roboto'),
            )
          ],
        ),
      ),
      backgroundColor: CoreStyle.tchpinBlack,
      body: SafeArea(
        top: true,
        child: TabBarView(
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [_buildAllRewards(), _buildMyRewards()],
        ),
      ),
    );
  }

  _buildMyRewards() {
    return Padding(
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
              if (state is GetRewardSuccessState) {
                myRewards = state.rewards;

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {});
                });

                return Text(
                  'My Redeemed Rewards',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: TchipinFontWeight.medium,
                      fontSize: 22.sp,
                      color: CoreStyle.white,
                      fontFamily: 'Roboto'),
                );
              } else if (state is GetRewardWaitingState) {
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
                    return Container(
                      height: 100.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: CoreStyle.white, width: 1.r),
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reward Name: ${myRewards[index].rewardName}',
                              style: TextStyle(
                                  fontWeight: TchipinFontWeight.medium,
                                  fontSize: 15.sp,
                                  color: CoreStyle.white,
                                  fontFamily: 'Roboto')),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                              'Exchange Date: ${DateFormat('yyyy/MM/dd hh:mm').format(myRewards[index].date!)}',
                              style: TextStyle(
                                  fontWeight: TchipinFontWeight.medium,
                                  fontSize: 15.sp,
                                  color: CoreStyle.white,
                                  fontFamily: 'Roboto')),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text('Price: ${myRewards[index].price}',
                              style: TextStyle(
                                  fontWeight: TchipinFontWeight.medium,
                                  fontSize: 15.sp,
                                  color: CoreStyle.white,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                    );
                  },
                  itemCount: myRewards.length))
        ],
      ),
    );
  }

  _buildAllRewards() {
    return ModalProgressHUD(
        inAsyncCall: isAsync,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              BlocListener<StepsBloc, StepsState>(
                listener: (context, state) {
                  if (state is GetHealthPointSuccessState) {
                    setState(() {
                      isAsync = false;
                    });
                    notUsedHealthPoints = 0;
                    for (var point in state.points) {
                      if (point.used == false) {
                        notUsedHealthPoints += 1;
                      }
                    }
                  } else if (state is AddRewardSuccessState) {
                    BlocProvider.of<StepsBloc>(context).add(GetUserHealthPoints(
                        GetUserStepsParam(
                            deviceId: appConfig.deviceUniqueIdentifier!)));
                    showSnackBack(context, 'Redeem Success');
                  }
                },
                child: Container(),
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 110.h,
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
                              Text('Name: ${rewards[index].name}',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  'Price: ${rewards[index].price} Health Point',
                                  style: TextStyle(
                                      fontWeight: TchipinFontWeight.medium,
                                      fontSize: 15.sp,
                                      color: CoreStyle.white,
                                      fontFamily: 'Roboto')),
                              SizedBox(
                                height: 8.h,
                              ),
                              TchipinButton(
                                  onPressed: () async {
                                    if (notUsedHealthPoints <
                                        rewards[index].price) {
                                      showSnackBack(context,
                                          'You don\'t have enough points to redeem this reward');
                                      return;
                                    }
                                    var name = await locator<IStepsRepository>()
                                        .getUserName();
                                    var deviceId =
                                        appConfig.deviceUniqueIdentifier;
                                    setState(() {
                                      isAsync = true;
                                      BlocProvider.of<StepsBloc>(context).add(
                                          AddReward(AddRewardParam(
                                              rewardModel: MyRewardModel(
                                                  rewardName:
                                                      rewards[index].name,
                                                  name: name!,
                                                  price: rewards[index].price,
                                                  date: DateTime.now(),
                                                  deviceId: deviceId!))));
                                    });
                                  },
                                  text: 'Redeem')
                            ],
                          ),
                        );
                      },
                      itemCount: rewards.length))
            ],
          ),
        ));
  }
}
