import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    '';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

class CustomTextField extends StatelessWidget {
  final Key textKey;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final String labelText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final String helperText;
  final int maxLength;
  final bool isPhone;

  const CustomTextField(
      {Key key,
      @required this.textKey,
      @required this.controller,
      @required this.textInputAction,
      @required this.keyboardType,
      @required this.focusNode,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.obscureText = false,
      this.helperText,
      this.maxLength,
      this.isPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.h,
        decoration: BoxDecoration(
            color: CoreStyle.white,
            borderRadius: BorderRadius.all(Radius.circular(14.r))),
        child: Row(
          children: [
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: TextFormField(
                cursorColor: CoreStyle.operationBlack2Color,
                style: TextStyle(
                    color: CoreStyle.operationBlack2Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 23.sp),
                key: textKey,
                maxLength: maxLength,
                controller: controller,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                focusNode: focusNode,
                decoration: InputDecoration(
                    isDense: false,
                    fillColor: CoreStyle.white.withOpacity(0.2),
                    contentPadding: EdgeInsets.only(left: 8, right: 9),
                    hintStyle: TextStyle(
                        color: CoreStyle.operationBlack2Color.withOpacity(0.5)),
                    hintText: helperText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorStyle:
                        const TextStyle(color: CoreStyle.operationBlack2Color)),
                validator: validator,
                onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
                obscureText: obscureText,
              ),
            ),
          ],
        ));
  }
}
