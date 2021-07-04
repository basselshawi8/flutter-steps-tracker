import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/ui/syrian_phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GTextFormField extends StatelessWidget {
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

  const GTextFormField({
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
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: CoreStyle.primaryTheme,
      style: CommonTextStyle.textFormFieldUserManagement,
      key: textKey,
      maxLength: maxLength,
      inputFormatters: keyboardType == TextInputType.phone
          ? [
              ArabicToEnglishTextInputFormatter(),
              PhoneNumberTextInputFormatter()
            ]
          : null,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      focusNode: focusNode,
      decoration: InputDecoration(
        helperStyle: const TextStyle(color: CoreStyle.White400),
        helperText: helperText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: CoreStyle.primaryTheme,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: CoreStyle.primaryTheme,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: CoreStyle.textColorRed,
          ),
        ),
        fillColor: CoreStyle.primaryTheme,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(
            color: CoreStyle.textColorRed,
          ),
        ),
        border: const UnderlineInputBorder(),
        isDense: false,
        labelStyle: CommonTextStyle.labelUserManagement,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorStyle: const TextStyle(height: 0.8),
      ),
      validator: validator,
      autovalidate: false,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
