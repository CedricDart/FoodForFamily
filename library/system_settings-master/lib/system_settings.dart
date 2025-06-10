import 'dart:async';

import 'package:flutter/services.dart';

class SystemSettings {
  static const MethodChannel _channel = MethodChannel('system_settings');

  static Future<void> app() async {
    return await _channel.invokeMethod('app');
  }

  static Future<void> system() async {
    return await _channel.invokeMethod('system');
  }

  static Future<void> security() async {
    return await _channel.invokeMethod('security');
  }

  static Future<void> deviceInfo() async {
    return await _channel.invokeMethod('device-info');
  }

  static Future<void> dataUsage() async {
    return await _channel.invokeMethod('data-usage');
  }

  static Future<void> privacy() async {
    return await _channel.invokeMethod('privacy');
  }

}
