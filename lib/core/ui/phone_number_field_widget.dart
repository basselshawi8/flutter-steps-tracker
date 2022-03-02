import 'package:micropolis_test/core/Common/Common.dart';
import 'package:micropolis_test/core/localization/translations.dart';
import 'package:micropolis_test/core/ui/syrian_phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFieldWidget extends StatelessWidget {
  final Key textKey;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final bool showhelper;

  const PhoneNumberFieldWidget({
    Key? key,
    required this.textKey,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.showhelper = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CommonTextStyle.textFormFieldUserManagement,
      key: textKey,
      maxLength: 12,
      cursorColor: Colors.white,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        ArabicToEnglishTextInputFormatter(),
        PhoneNumberTextInputFormatter()
      ],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        counterText: "",
        helperText: showhelper
            ? (Translations.of(context)?.translate("text_helper_phone") ?? "")
            : null,
        helperStyle: const TextStyle(color: CoreStyle.White400),
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
        labelText: Translations.of(context)?.translate('hint_phone') ?? "",
        prefixIcon: Icon(
          Icons.phone,
          color: CoreStyle.primaryTheme,
        ),
      ),
      validator: (value) {
        if (Validators.isValidPhoneNumber(value ?? ""))
          return null;
        else
          return Translations.of(context)?.translate('error_phone_invalid') ??
              "";
      },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
