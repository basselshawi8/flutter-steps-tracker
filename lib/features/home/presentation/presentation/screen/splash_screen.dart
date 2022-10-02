import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/home_screen.dart';

import '../../../../../service_locator.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkIfNameExist();
    super.initState();
  }

  _checkIfNameExist() async {
    var name = await locator<IStepsRepository>().getUserName();
    if (name == null) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreStyle.tchpinBlack,
      body: Center(
        child: Text(
          'Steps Tracker',
          style: TextStyle(
              fontWeight: TchipinFontWeight.medium,
              fontSize: 22.sp,
              fontFamily: 'Roboto'),
        ),
      ),
    );
  }
}
