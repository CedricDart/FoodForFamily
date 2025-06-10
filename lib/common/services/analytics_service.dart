import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/common/utils/platform.dart';
import 'package:food_for_family/common/utils/shared_prefs.dart';
import 'package:recase/recase.dart';

class AnalyticsEvents {
  static String serviceDeliveryPointSelected = 'service_point_selected';
  static String searchingServiceDeliveryPoint = 'searching_service_point';
  static String gpsTurnedOn = 'gps_turned_on';
  static String gpsTurnedOff = 'gps_turned_off';
  static String deviceRegistered = 'device_registered';

  static String menuClick = 'menu_click';

  static String feedbackSent = 'feedback_sent';

  static String feedbackFormImpression = 'feedback_form_impression';
}

class EventParameters {
  static String appVersion = 'app_version';
  static String loginMethod = 'login_method';
  static String errorType = 'error_type';
  static String menuItem = 'menu_item';
  static String searchTerm = 'search_term';
  static String searchSection = 'search_section';
  static String timestamp = 'time_stamp';
}

class UserProperties {
  static String userLanguage = 'user_language';
  static String userType = 'user_type';
  static String appVersion = 'app_version';
}

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final SharedPreferenceHelper _preferences = locator<SharedPreferenceHelper>();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics, nameExtractor: _screenNameExtractor);

  AnalyticsService() {
    _initialize();
  }

  Future<void> logEvent(String eventName, {Map<String, Object>? parameters}) async {
    var params = await _getCommonEventParameters();
    if (parameters != null) {
      params?.addAll(parameters);
    }

    _analytics.logEvent(name: eventName, parameters: params);
  }

  // User properties
  Future<void> setUserProperties() async {
    var language = await _preferences.getLanguage();
    var appVersion = await PlatformUtil.getVersion();
    String? userId;

    _analytics.setUserId(id: userId);
    //_analytics.setUserProperty(name: UserProperties.userType, value: state.name);
    _analytics.setUserProperty(name: UserProperties.userLanguage, value: language);
    _analytics.setUserProperty(name: UserProperties.appVersion, value: appVersion);
  }

  // Login
  void logLogin() async {
    _analytics.logLogin(loginMethod: 'password');
  }

  // Device
  void logDeviceRegistration() {
    logEvent(AnalyticsEvents.deviceRegistered);
  }

  // Menu
  void logMenuClick({required String item}) {
    logEvent(AnalyticsEvents.menuClick, parameters: {EventParameters.menuItem: item});
  }

  // Search
  void logSearch({required String query}) async {
    _analytics.logSearch(searchTerm: query);
  }

  // Private
  void _initialize() async {
    _analytics.setAnalyticsCollectionEnabled(true);
    FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  }

  Future<Map<String, Object>?> _getCommonEventParameters() async {
    var appVersion = await PlatformUtil.getVersion();
    var timestamp = DateTime.now().toIso8601String();

    return {EventParameters.appVersion: appVersion, EventParameters.timestamp: timestamp};
  }

  String? _screenNameExtractor(RouteSettings settings) {
    var routeName = settings.name;

    /*if (routeName == routeWebView) {
      var arguments = settings.arguments as InAppWebViewArguments;
      routeName = arguments.url.replaceAll('https://', '');
    }*/

    routeName = routeName?.replaceAll('/', '').snakeCase;

    return routeName;
  }
}
