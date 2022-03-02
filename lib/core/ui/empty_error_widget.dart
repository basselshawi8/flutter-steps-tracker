import 'package:micropolis_test/core/localization/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyErrorScreenWidget extends StatelessWidget {
  final String message;
  final String? image;
  final VoidCallback? callback;
  final buttonText;

  const EmptyErrorScreenWidget({
    Key? key,
    required this.message,
    this.callback,
    this.image,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image == null
              ? const SizedBox()
              : SizedBox(
                  height: 200.h,
                  width: 200.w,
                  child: image != null ? Image.asset(image!) : null,
                ),
          Text(
            message ?? (Translations.of(context)?.translate("empty") ?? ""),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            onPressed: callback,
            child: Text(
              buttonText ?? (Translations.of(context)?.translate('btn_Rty_title') ?? ""),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
