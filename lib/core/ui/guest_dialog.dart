import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/localization/translations.dart';
import 'package:micropolis_test/core/ui/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showGuestDialog({
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(35)),
            width: CoreStyle.setWidthPercentage(75, context),
            padding: EdgeInsets.all(ScreenUtil().setWidth(35)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            color: CoreStyle.primaryTheme,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.person, color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(35),),
                        Text(Translations.of(context)
                            ?.translate("label_log_in_as_guest") ?? "",)
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            color: CoreStyle.primaryTheme,
                            child: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.forward, color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(35),),
                        Text(Translations.of(context)
                            ?.translate("label_log_in") ?? "")
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
