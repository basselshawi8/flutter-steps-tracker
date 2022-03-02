import 'package:micropolis_test/core/localization/translations.dart';
import 'package:micropolis_test/core/ui/error_widget.dart';
import 'package:micropolis_test/core/ui/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';

showMessageDialog(BuildContext context,
    {IconData? topIcon,
    Color? iconColor,
    Color? iconBackgroundColor,
    String? message,
    ErrorScreenWidget? errorWidget,
    Function? onConfirmPressed}) {
  ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(60))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    maxRadius: ScreenUtil().setWidth(50),
                    child: Icon(
                      topIcon ?? Icons.check,
                      color: iconColor ?? Colors.white,
                      size: ScreenUtil().setWidth(80),
                    ),
                    backgroundColor: iconBackgroundColor ?? Colors.green,
                  ),
                  if (errorWidget == null)
                    Text(
                      message ??
                          (Translations.of(context)
                                  ?.translate("order_success") ??
                              ""),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(42)),
                    )
                  else
                    errorWidget,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: errorWidget == null
                            ? (Translations.of(context)
                                    ?.translate("label_confirm") ??
                                "")
                            : (Translations.of(context)
                                    ?.translate("label_cancel") ??
                                ""),
                        onPressed: onConfirmPressed ?? () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
