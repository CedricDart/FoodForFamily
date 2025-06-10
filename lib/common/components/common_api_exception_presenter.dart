
import 'package:flutter/material.dart';
import 'package:food_for_family/app.dart';
import 'package:food_for_family/common/components/alerts.dart';
import 'package:food_for_family/common/services/api_service.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/generated/l10n.dart';

class CommonApiExceptionPresenter {
  static present({String? title, String? message}) {
    if (navigatorKey.currentContext != null) {
      title ??= S.current.label_general_api_exception_title;
      message ??= S.current.label_general_api_exception_message;
      presentTwoButtonAlert(
          navigatorKey.currentContext!, Text(title), Text(message), [
        TextButton(
          onPressed: () => {
            Navigator.of(navigatorKey.currentContext!).pop(),
            locator<WebApiService>().retry()
          },
          child: Text(S.current.label_general_api_exception_button_retry),
        ),
        TextButton(
          onPressed: () => {Navigator.pop(navigatorKey.currentContext!)},
          child: Text(S.current.label_common_button_cancel),
        )
      ]);
    }
  }
}
