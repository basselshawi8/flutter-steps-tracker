import 'package:micropolis_test/core/Common/Utils.dart';
import 'package:micropolis_test/core/errors/bad_request_error.dart';
import 'package:micropolis_test/core/errors/conflict_error.dart';
import 'package:micropolis_test/core/errors/connection_error.dart';
import 'package:micropolis_test/core/errors/custom_error.dart';
import 'package:micropolis_test/core/errors/forbidden_error.dart';
import 'package:micropolis_test/core/errors/not_found_error.dart';
import 'package:micropolis_test/core/errors/timeout_error.dart';
import 'package:micropolis_test/core/errors/unauthorized_error.dart';
import 'package:micropolis_test/core/errors/unknown_error.dart';
import 'package:micropolis_test/core/localization/restart_widget.dart';
import 'package:micropolis_test/core/localization/translations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../service_locator.dart';
import 'custom_button.dart';
import 'show_dialog.dart';

class ErrorViewer {
  static showSnakBar(BuildContext context, dynamic state) {
    if (state.error.runtimeType is ConnectionError) {
      ErrorViewer.showConnectionError(context, state.callback);
    } else if (state.error is CustomError) {
      ErrorViewer.showCustomError(context, state.error.message);
    } else if (state.error is UnauthorizedError) {
      ErrorViewer.showUnauthorizedError(context);
    } else if (state.error is BadRequestError) {
      ErrorViewer.showBadRequestError(context, state.error.message);
    } else if (state.error is ForbiddenError) {
      ErrorViewer.showForbiddenError(context);
    } else if (state.error is NotFoundError) {
      ErrorViewer.showNotFoundError(context);
    } else if (state.error is ConflictError) {
      ErrorViewer.showConflictError(context);
    } else if (state.error is TimeoutError) {
      ErrorViewer.showTimeoutError(context);
    } else if (state.error is UnknownError) {
      ErrorViewer.showUnknownError(context);
    } else {
      ErrorViewer.showUnexpectedError(context);
    }
  }

  static void showConnectionError(BuildContext context, VoidCallback callback) {
    ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(60))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    maxRadius: ScreenUtil().setWidth(50),
                    child: Icon(
                      Icons.signal_wifi_off,
                      color: Colors.white,
                      size: ScreenUtil().setWidth(80),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  Text(
                    Translations.of(context).translate("error_oops"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(42)),
                  ),
                  Text(
                    Translations.of(context).translate("error_connection"),
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(42)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text:
                            Translations.of(context).translate("btn_Rty_title"),
                        onPressed: () {
                          Navigator.pop(context);
                          callback();
                        },
                      ),
                      CustomButton(
                        text:
                            Translations.of(context).translate("btn_close_app"),
                        onPressed: () async => await SystemNavigator.pop(),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showCustomError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showUnexpectedError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).translate('error_general')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showUnauthorizedError(BuildContext context) {
    final snackBar = SnackBar(
      content:
          Text(Translations.of(context).translate('error_Unauthorized_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);

  }

  static void showBadRequestError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message ??
          Translations.of(context).translate('error_BadRequest_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showForbiddenError(BuildContext context) {
    final snackBar = SnackBar(
      content:
          Text(Translations.of(context).translate('error_forbidden_error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);

  }

  static void showNotFoundError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).translate('error_NotFound_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showConflictError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).translate('error_Conflict_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showTimeoutError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).translate('error_Timeout_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showUnknownError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Translations.of(context).translate('error_Unknown_Error')),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static showDialogForSplash(BuildContext context, String message,VoidCallback callback){
    ShowDialog().showElasticDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(ScreenUtil().setWidth(60))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    Translations.of(context).translate("error_oops"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(42)),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(42)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text:
                        Translations.of(context).translate("btn_Rty_title"),
                        onPressed: () {
                          Navigator.pop(context);
                          callback();
                        },
                      ),
                      CustomButton(
                        text:
                        Translations.of(context).translate("btn_close_app"),
                        onPressed: () async => await SystemNavigator.pop(),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
