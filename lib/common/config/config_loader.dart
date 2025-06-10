import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_for_family/common/config/environment_config.dart';

abstract class ConfigLoader {
  static Future<void> load(EnvironmentConfig config) async {
    await dotenv.load(
        fileName: 'environment/.' + getConfigName(config) + '.env');
  }

  static String getConfigName(EnvironmentConfig config) {
    switch (config) {
      case EnvironmentConfig.str:
        return 'str';
    }
  }
}
