import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    '';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

class LoginTextField extends StatelessWidget {
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
  final double height;

  const LoginTextField({
    Key key,
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
    this.height,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helperText,
          style: TextStyle(
              color: CoreStyle.operationTextBlueColor,
              fontSize: 15.sp,
              fontFamily: CoreStyle.fontWithWeight(FontWeight.w400)),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
            height: this.height ?? 55.h,
            decoration: BoxDecoration(
                border: Border.all(
                    color: CoreStyle.operationLoginTextFieldBorderColor,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
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
                        fontSize: this.height != null ? 17.sp : 23.sp),
                    key: textKey,
                    maxLength: maxLength,
                    controller: controller,
                    textInputAction: textInputAction,
                    keyboardType: keyboardType,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                        isDense: false,
                        fillColor: CoreStyle.white.withOpacity(0.2),
                        contentPadding: EdgeInsets.only(
                            left: 8,
                            right: 9,
                            bottom: this.height != null ? 11 : 5),
                        hintStyle: TextStyle(
                            color: CoreStyle.operationBlack2Color
                                .withOpacity(0.5)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorStyle: const TextStyle(
                            color: CoreStyle.operationBlack2Color)),
                    validator: validator,
                    autovalidate: false,
                    onFieldSubmitted: onFieldSubmitted,
                    onChanged: onChanged,
                    obscureText: obscureText,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
