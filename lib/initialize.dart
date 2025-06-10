import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_for_family/common/components/internet_connection_alert_presenter.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/common/services/performance_service.dart';

import 'common/config/config_loader.dart';
import 'common/config/environment_config.dart';
import 'common/services/remote_config_service.dart';
import 'common/utils/locator.dart';

Future<void> initialize(EnvironmentConfig config, {required WidgetsBinding binding, required Map<LogLevel, bool> logLevels}) async {
  // Initialize config
  await ConfigLoader.load(config);

  // Initialize Firebase
  var firebase = await Firebase.initializeApp();

  // Setup dependency injection
  await setupLocator(firebase, config);

  var logger = locator<LoggerService>();
  logger.configure(characters: {LogLevel.error: '🔴', LogLevel.debug: '🟡', LogLevel.info: '🔵', LogLevel.analytics: '📊'}, levels: logLevels);

  // Initialize Firebase remote config
  await locator<RemoteConfigService>().initialise();

  // Initialize Firebase performance traces
  await locator<PerformanceService>().initialiseTraces();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Set orientation
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // Preload assets to prevent flash when they are loaded.
  binding.deferFirstFrame();
  binding.addPostFrameCallback((_) async {
    InternetConnectionAlertPresenter();

    binding.allowFirstFrame();
  });
}
