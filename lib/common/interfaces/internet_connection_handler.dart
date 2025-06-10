import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/common/utils/locator.dart';

class InternetConnectionHandler {
  final StreamController<bool> _toggleInternetConnectionErrorPopup =
      StreamController();

  Stream<bool> get onToggleInternetConnectionErrorPopup =>
      _toggleInternetConnectionErrorPopup.stream;

  bool _isInternetConnectionPopupShown = false;

  bool get isInternetConnectionPopupShown => _isInternetConnectionPopupShown;

  StreamSubscription<ConnectivityResult>? _subscription;

  final Connectivity _connectivity = Connectivity();

  final LoggerService _logger = locator<LoggerService>();

  Future<void> listenToConnectionChanges() async {
    // First time check
    if (!(await hasInternetConnection())) {
      _handleInternetConnection(true);
    }

    // Subscribe to changes
    try {
      _subscription = _connectivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.none) {
          _handleInternetConnection(true);
        } else {
          _handleInternetConnection(false);
        }
      }) as StreamSubscription<ConnectivityResult>?;
    } on Exception catch (e) {
      _logger.error(e, stack: StackTrace.current);
    }
  }

  Future<bool> hasInternetConnection() async {
    try {
      var result = await _connectivity.checkConnectivity();
      _logger.debug(result);
      return result != ConnectivityResult.none;
    } on Exception catch (e) {
      _logger.error(e, stack: StackTrace.current);
      return true;
    }
  }

  Future<void> cancelConnectivitySubscription() async {
    await _subscription?.cancel();
  }

  void _handleInternetConnection(bool isNotConnected) {
    if (isNotConnected && !isInternetConnectionPopupShown) {
      _isInternetConnectionPopupShown = true;
      _toggleInternetConnectionErrorPopup.add(true);
      _logger.info('No internet connection');
    } else {
      if (isInternetConnectionPopupShown) {
        _toggleInternetConnectionErrorPopup.add(false);
        _isInternetConnectionPopupShown = false;
        _logger.info('Internet connection is available');
      }
    }
  }
}
