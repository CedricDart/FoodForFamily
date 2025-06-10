import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/common/constants/colors.dart';
import 'package:food_for_family/generated/l10n.dart';

void presentOneButtonAlert(BuildContext context, Text titleWidget, Text contentWidget, TextButton actionWidget) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: <Widget>[actionWidget],
      ),
    );
  } else {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: <Widget>[actionWidget],
      ),
    );
  }
}

void presentTwoButtonAlert(BuildContext context, Text titleWidget, Text contentWidget, List<TextButton> actionWidgets) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actionWidgets,
      ),
    );
  } else {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actionWidgets,
      ),
    );
  }
}

void presentNoInternetConnectionAlert(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WillPopScope(
              onWillPop: () async => false,
              child: CupertinoAlertDialog(
                title: Text(S.of(context).label_common_internet_connection_error_title),
                content: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(S.of(context).label_common_internet_connection_error_body),
                    const Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 20), child: CircularProgressIndicator(color: AppColors.brandSecondaryBase)),
                  ],
                ),
              ),
            ));
  } else {
    showDialog<String>(
        context: context,
        barrierColor: AppColors.black.withAlpha(50),
        barrierDismissible: false,
        builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(S.of(context).label_common_internet_connection_error_title),
              content: SizedBox(
                  height: 160,
                  child: Column(
                    children: [
                      Text(S.of(context).label_common_internet_connection_error_body),
                      const Padding(padding: EdgeInsets.only(top: 20), child: CircularProgressIndicator(color: AppColors.brandSecondaryBase)),
                    ],
                  )),
            )));
  }
}
