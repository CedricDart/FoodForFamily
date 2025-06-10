import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/app.dart';
import 'package:food_for_family/common/components/alerts.dart';

class InternetConnectionAlertPresenter {
  bool _isInternetConnectionPopupShown = false;

  bool get isInternetConnectionPopupShown => _isInternetConnectionPopupShown;

  final Connectivity _connectivity = Connectivity();

  static InternetConnectionAlertPresenter? _instance;

  factory InternetConnectionAlertPresenter() => _instance ??= InternetConnectionAlertPresenter._();

  InternetConnectionAlertPresenter._() {
    _listenToConnectionChanges();
  }

  Future<void> _listenToConnectionChanges() async {
    // First time check
    if (!(await hasInternetConnection())) {
      _handleInternetConnection(true);
    }

    // Subscribe to changes
    try {
      _connectivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.none) {
          _handleInternetConnection(true);
        } else {
          _handleInternetConnection(false);
        }
      });
    } on Exception catch (_) {}
  }

  Future<bool> hasInternetConnection() async {
    try {
      var result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on Exception catch (_) {
      return true;
    }
  }

  void _handleInternetConnection(bool isNotConnected) {
    if (navigatorKey.currentContext != null) {
      if (isNotConnected && !isInternetConnectionPopupShown) {
        _isInternetConnectionPopupShown = true;
        if (navigatorKey.currentContext != null) {
          presentNoInternetConnectionAlert(navigatorKey.currentContext!);
        }
      } else {
        if (isInternetConnectionPopupShown) {
          _isInternetConnectionPopupShown = false;
          Navigator.of(navigatorKey.currentContext!).pop();
        }
      }
    }
  }
}
