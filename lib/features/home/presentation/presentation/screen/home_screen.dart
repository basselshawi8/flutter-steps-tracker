import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/params/no_params.dart';
import 'package:micropolis_test/features/home/presentation/bloc/steps_event.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/leadboard_screen.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/pointsScreen.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/rewards_screen.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/steps_screen.dart';
import '../../../../../PedoMeterUtil.dart';
import '../../../data/model/steps_model.dart';
import '../../bloc/steps_bloc.dart';
import '../../bloc/steps_state.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homeScreen';

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseFirestore firestore;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    StepsScreen(),
    PointsScreen(),
    RewardsScreen(),
    LeadBoardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.nordic_walking,color: CoreStyle.white,),
                label: 'Steps',
                backgroundColor: CoreStyle.tchpinOrangeColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.star,color: CoreStyle.white),
                label: 'Points',
                backgroundColor: CoreStyle.tchpinOrangeColor),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_giftcard_outlined,color: CoreStyle.white),
              label: 'Rewards',
              backgroundColor: CoreStyle.tchpinOrangeColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reduce_capacity,color: CoreStyle.white),
              label: 'Leadboard',

              backgroundColor: CoreStyle.tchpinOrangeColor,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
/*
StreamBuilder<StepsModel>(
            stream: meter.numberOfStepsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                numberOfSteps += snapshot.data?.steps ?? 0;

                CollectionReference stepsFireStore =
                    firestore.collection('steps');

                stepsFireStore
                    .add(snapshot.data!.toMap())
                    .then((value) => BlocProvider.of<StepsBloc>(context)
                        .add(GetSteps(NoParams())))
                    .catchError((error) => print("Failed to add user: $error"));
              }
              return Center(
                child: Text('$numberOfSteps'),
              );
            },
          ),
          BlocBuilder<StepsBloc, StepsState>(builder: (context, state) {
            if (state is GetStepsSuccessState) {
              return Text('${state.steps.length}');
            } else {
              return Container();
            }
          })*/
