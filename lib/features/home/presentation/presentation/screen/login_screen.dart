import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/tchipin_button.dart';
import 'package:micropolis_test/core/ui/tchipin_textfield.dart';
import 'package:micropolis_test/core/utils.dart';
import 'package:micropolis_test/features/home/domain/repository/isteps_repository.dart';
import 'package:micropolis_test/features/home/presentation/presentation/screen/home_screen.dart';
import 'package:micropolis_test/service_locator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  var nameKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var nameFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreStyle.tchpinBlack,
      body: SafeArea(
        top: true,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                      color: CoreStyle.tchpinOrangeColor,
                      fontFamily: 'Roboto',
                      fontSize: 22.sp,
                      fontWeight: TchipinFontWeight.bold),
                ),
                SizedBox(height: 20.h),
                TchipinTextField(
                    helperText: 'Please Enter your Name',
                    textKey: nameKey,
                    controller: nameController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    focusNode: nameFocusNode),
                SizedBox(height: 20.h),
                TchipinButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        showSnackBack(context, 'Please Enter your Name');
                        return;
                      }
                      if (await locator<IStepsRepository>()
                          .saveUserName(nameController.text)) {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      } else {
                        showSnackBack(context, 'Error Saving Name');
                      }
                    },
                    text: 'Submit')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
