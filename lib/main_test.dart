import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/app.dart';
import 'package:food_for_family/common/config/environment_config.dart';
import 'package:food_for_family/common/data/fakedata.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/initialize.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  await initialize(EnvironmentConfig.str, binding: binding, logLevels: {
    LogLevel.debug: true,
    LogLevel.analytics: true,
    LogLevel.info: true,
    LogLevel.error: true,
  });

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await populateDatabaseWithFakeRecipes(3);
  runApp(const App());
}
