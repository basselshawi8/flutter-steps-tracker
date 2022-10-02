import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    '';
import 'package:micropolis_test/core/Common/CoreStyle.dart';

class TchipinTextField extends StatelessWidget {
  final Key textKey;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? helperText;
  final int? maxLength;
  final bool? isPhone;

  const TchipinTextField(
      {Key? key,
      required this.textKey,
      required this.controller,
      required this.textInputAction,
      required this.keyboardType,
      required this.focusNode,
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
        height: 38.h,
        decoration: BoxDecoration(
            color: CoreStyle.tchpinLightGrayColor,
            borderRadius: BorderRadius.all(Radius.circular(19.h))),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                    textSelectionTheme: TextSelectionThemeData(
                        cursorColor: CoreStyle.tchpinOrangeColor,
                        selectionHandleColor: CoreStyle.tchpinOrangeColor,
                        selectionColor:
                            CoreStyle.tchpinOrangeColor.withOpacity(0.3))),
                child: TextFormField(
                  cursorColor: CoreStyle.tchpinOrangeColor,
                  style: TextStyle(
                      color: CoreStyle.tchpinBlack,
                      fontWeight: TchipinFontWeight.light,
                      fontFamily: 'Roboto',
                      fontSize: 9.sp),
                  key: textKey,
                  maxLength: maxLength,
                  controller: controller,
                  textInputAction: textInputAction,
                  keyboardType: keyboardType,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 13.h, top: 8.h),
                      isDense: false,
                      fillColor: Colors.transparent,
                      floatingLabelStyle: TextStyle(
                          color: CoreStyle.tchpinOrangeColor,
                          fontWeight: TchipinFontWeight.light,
                          fontSize: 8.sp),
                      labelText: helperText,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorStyle: TextStyle(
                          color: CoreStyle.textColorRed,
                          fontWeight: TchipinFontWeight.light,
                          fontFamily: 'Roboto',
                          fontSize: 9.sp)),
                  validator: validator,
                  onFieldSubmitted: onFieldSubmitted,
                  onChanged: onChanged,
                  obscureText: obscureText,
                ),
              ),
            ),
            if (suffixIcon != null) suffixIcon!
          ],
        ));
  }
}
