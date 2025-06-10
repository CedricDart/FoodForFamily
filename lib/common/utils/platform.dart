import 'dart:io';

import 'package:food_for_family/common/config/config_loader.dart';
import 'package:food_for_family/common/config/environment.dart';
import 'package:food_for_family/common/config/environment_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'locator.dart';

class PlatformUtil {
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  static Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.buildNumber;
  }

  static String environment() {
    EnvironmentConfig config = locator<Environment>().config;
    return ConfigLoader.getConfigName(config);
  }

  static String getDeviceLanguageCode() {
    String localeName = Platform.localeName.toLowerCase();
    var split = localeName.split('_');
    var extractedLanguage = '';
    if (split.length == 2) {
      extractedLanguage = split[0];
    } else {
      extractedLanguage = localeName;
    }

    return extractedLanguage;
  }
}
