import 'package:flutter/material.dart';
import 'package:food_for_family/app.dart';
import 'package:food_for_family/common/config/environment_config.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/initialize.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  await initialize(EnvironmentConfig.str, binding: binding, logLevels: {
    LogLevel.debug: false,
    LogLevel.analytics: false,
    LogLevel.info: false,
    LogLevel.error: false,
  });
  runApp(const App());
}
