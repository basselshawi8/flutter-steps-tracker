import 'package:micropolis_test/core/Common/CoreStyle.dart';
import 'package:micropolis_test/core/localization/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDialog {
  Future<T> showElasticDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: _buildDialogTransitions,
    );
  }

  Widget _buildDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: animation,
          curve: const ElasticOutCurve(0.85),
          reverseCurve: Curves.easeOutBack,
        )),
        child: child,
      ),
    );
  }
}

void textFieldDialog({BuildContext context, String message, String title,
  int linesNumber = 1, int maxChars, Function(String value) onAccept}) async {
  final messageController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(25)))),
        title: Text(
          title,
          style: CommonTextStyle.medBlackNormalText,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxChars ?? 256),
              ],
              style: CommonTextStyle.textFormFieldAddAddress,
              cursorColor: Colors.black87,
              controller: messageController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                  borderSide: const BorderSide(
                    color: CoreStyle.White400,
                  ),
                ),
                errorStyle: const TextStyle(height: 0.8),
                border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                ),
                isDense: false,
                labelStyle: CommonTextStyle.labelAddAddress,
                labelText: message,
                prefixIcon: const Icon(
                  Icons.assignment,
                  color: CoreStyle.primaryTheme,
                ),
              ),
              validator: (value) {
                return value;
              },
              autovalidate: false,
              onChanged: (value) {},
              maxLines: linesNumber,
              minLines: 1,
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              Translations.of(context).translate("label_cancel"),
              style: CommonTextStyle.normalPrimarySmallText,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(
              Translations.of(context).translate("label_confirm"),
              style: CommonTextStyle.normalPrimarySmallText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onAccept(messageController.text);
            },
          )
        ],
      );
    },
  );
}
