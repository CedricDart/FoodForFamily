import 'package:flutter/cupertino.dart';
import 'package:food_for_family/common/services/analytics_service.dart';
import 'package:food_for_family/common/services/api_service.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/common/services/notificationService.dart';
import 'package:food_for_family/common/services/performance_service.dart';
import 'package:food_for_family/common/services/recipeService.dart';
import 'package:food_for_family/common/services/remote_config_service.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/common/utils/secure_storage.dart';
import 'package:food_for_family/common/utils/shared_prefs.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool _mounted = true;

  bool get mounted => _mounted;

  bool get shouldShowLoading => _isLoading;

  RemoteConfigService get remoteConfig {
    return locator<RemoteConfigService>();
  }

  PerformanceService get performanceTrace {
    return locator<PerformanceService>();
  }

  NotificationService get notificationService {
    return locator<NotificationService>();
  }

  SecureStorage get appSecureStorage {
    return locator<SecureStorage>();
  }

  SharedPreferenceHelper get preferences {
    return locator<SharedPreferenceHelper>();
  }

  RecipeService get recipeService {
    return locator<RecipeService>();
  }

  LoggerService get logger {
    return locator<LoggerService>();
  }

  AnalyticsService get analytics {
    return locator<AnalyticsService>();
  }

  ApiService get api {
    return locator<WebApiService>();
  }

  void setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
