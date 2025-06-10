import 'package:firebase_core/firebase_core.dart';
import 'package:food_for_family/common/config/environment.dart';
import 'package:food_for_family/common/config/environment_config.dart';
import 'package:food_for_family/common/services/analytics_service.dart';
import 'package:food_for_family/common/services/api_service.dart';
import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/common/services/notificationService.dart';
import 'package:food_for_family/common/services/performance_service.dart';
import 'package:food_for_family/common/services/recipeService.dart';
import 'package:food_for_family/common/services/remote_config_service.dart';
import 'package:food_for_family/common/services/request_queue.dart';
import 'package:food_for_family/common/utils/secure_storage.dart';
import 'package:food_for_family/common/utils/shared_prefs.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator(FirebaseApp app, EnvironmentConfig config) async {
  RequestQueue.queue.remainingItems.listen((numberOfItems) => print('### Number of items remaining on queue: $numberOfItems'));

  var remoteConfigService = await RemoteConfigService.getInstance();

  locator.registerLazySingleton(() => Environment(config));
  locator.registerLazySingleton(() => remoteConfigService);
  locator.registerLazySingleton(() => SharedPreferenceHelper());

  // Order needs to be there for injections, since injected instances
  // can make use of other injected instances
  locator.registerLazySingleton(() => AnalyticsService());

  locator.registerLazySingleton(() => LoggerService());
  var performanceService = await PerformanceService.getInstance();
  locator.registerLazySingleton(() => performanceService);

  locator.registerLazySingleton(() => WebApiService());

  locator.registerLazySingleton(() => SecureStorage());
  locator.registerLazySingleton(() => RecipeService());
  locator.registerLazySingleton(() => NotificationService());
}
