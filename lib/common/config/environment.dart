import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_for_family/common/config/environment_config.dart';

// This model should map all properties defined on .env files
class Environment {
  // API
  String baseUrl = '';
  String apiPath = '';
  String apiKey = '';

  // MOCK API
  String mockBaseUrl = '';
  String mockApiPath = '';
  String mockApiKey = '';

  // Feedback API
  String feedbackBaseApiUrl = '';
  String feedbackApiKey = '';

  // OCR API
  String priceReportingBaseApiUrl = '';
  String priceReportingApiKey = '';


  // Flavor
  EnvironmentConfig config;

  Environment(this.config) {
    baseUrl = dotenv.env['BASE_API_URL'] as String;
    apiPath = dotenv.env['API_PATH'] as String;
    apiKey = dotenv.env['API_KEY'] as String;

    mockBaseUrl = dotenv.env['MOCK_BASE_API_URL'] as String;
    mockApiPath = dotenv.env['MOCK_API_PATH'] as String;
    mockApiKey = dotenv.env['MOCK_API_USER_KEY'] as String;

    feedbackBaseApiUrl = dotenv.env['FEEDBACK_BASE_API_URL'] as String;
    feedbackApiKey = dotenv.env['FEEDBACK_API_KEY'] as String;

    priceReportingBaseApiUrl =
        dotenv.env['PRICE_REPORTING_BASE_API_URL'] as String;
    priceReportingApiKey = dotenv.env['PRICE_REPORTING_API_KEY'] as String;

  }
}
