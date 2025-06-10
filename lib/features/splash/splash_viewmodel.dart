import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_for_family/common/services/language_service.dart';
import 'package:food_for_family/common/utils/platform.dart';
import 'package:food_for_family/common/viewmodels/base_viewmodel.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:provider/provider.dart';

class SplashViewModel extends BaseViewModel {
  Stream<List<Recipe>> get onSkip => _onSkip.stream;

  final StreamController<List<Recipe>> _onSkip = StreamController();

  StreamSubscription<ConnectivityResult>? _connectionSubscription;

  Future<void> initialize(BuildContext context) async {
    var userLanguage = await preferences.getLanguage();

    await FirebaseAuth.instance.signInAnonymously();

    var token = await getFCMToken();
    await storeFCMToken(token);

    FirebaseMessaging.instance.subscribeToTopic('dailyRecipes');
    await notificationService.initializeNotifications();

    // User already selected a language
    // Set app language to selected language and continue
    if (userLanguage.isNotEmpty) {
      Provider.of<LanguageChangeProvider>(context, listen: false).changeLocale(userLanguage);

      logger.info('User already has language preference: $userLanguage');

      _proceedOnFlow();
    } else {
      // User not selected a language
      var deviceLanguage = PlatformUtil.getDeviceLanguageCode();

      // Device language is NL or FR
      // Set app language to device language and continue
      Provider.of<LanguageChangeProvider>(context, listen: false).changeLocale(deviceLanguage);
      preferences.setLanguage(deviceLanguage);

      logger.info('App language set as device language: $userLanguage');

      _proceedOnFlow();
    }
  }

  Future<String?> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token;
  }

  Future<void> _proceedOnFlow() async {
    // Fetch all recipes already
    var recipes = await recipeService.listRecipes();

    Future.delayed(const Duration(milliseconds: 3225), () {
      _onSkip.add(recipes);
    });
  }

  Future<void> storeFCMToken(String? token) async {
    if (token == null) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tokens') // To store multiple tokens (for multiple devices)
          .doc(token) // Token as the document ID
          .set({
        'token': token,
        'createdAt': FieldValue.serverTimestamp(), // Track token creation date
      });
    }
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }
}
