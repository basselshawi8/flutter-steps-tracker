import 'package:micropolis_test/core/localization/translations.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadingText: "",
      noDataText: Translations.of(context)?.translate('no_data_refresher') ?? "",
      failedText: Translations.of(context)?.translate('failed_refresher') ?? "",
      idleText: "",
      canLoadingText: "",
    );
  }
}