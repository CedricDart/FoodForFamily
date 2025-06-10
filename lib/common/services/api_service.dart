import 'dart:async';

import 'package:food_for_family/common/exceptions/unauthorized_exception.dart';
import 'package:food_for_family/common/models/base/serializable.dart';
import 'package:food_for_family/common/services/base/base_api_service.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/common/utils/secure_storage.dart';

abstract class ApiService extends BaseApiService {
  Future<void> getDeviceEnrollmentStatus();

  Future<void> revokeDeviceEnrollment(int deviceEnrollId);

  Future<dynamic> getGateway(String path, Map<String, dynamic>? query, String traceName,
      {bool isMock = false, bool isSecure = true, int retryCount = 2}) async {
    final uri = _getUri(path, query);
    final headers = await _getHeaders(isSecure);

    try {
      return await get(uri, headers, query, traceName);
    } on Exception catch (e) {
      logger.info('Exception on API side : $e');

      throw UnauthorizedException('');
    }
  }

  Future<dynamic> postGateway(String path, Serializable request, String traceName,
      {bool isMock = false, bool isSecure = true, int retryCount = 2}) async {
    final uri = _getUri(path, null);
    final headers = await _getHeaders(isSecure);

    try {
      return await post(uri, headers, request, traceName);
    } on Exception catch (e) {
      logger.info('Exception on API side : $e');

      throw UnauthorizedException('');
    }
  }

  Future<dynamic> deleteGateway(String path, Serializable request, String traceName,
      {bool isMock = false, bool isSecure = true, int retryCount = 2}) async {
    final uri = _getUri(path, null);
    final headers = await _getHeaders(isSecure);

    try {
      return await delete(uri, headers, request, traceName);
    } on Exception catch (e) {
      logger.info('Exception on API side : $e');

      throw UnauthorizedException('');
    }
  }

  Uri _getUri(String path, Map<String, dynamic>? query);

  // ignore: unused_element
  String _getFullPath(String path);

  Future<Map<String, String>> _getHeaders(bool isSecure);
}

class WebApiService extends ApiService {
  final SecureStorage _secureStorage = locator<SecureStorage>();

  @override
  Uri _getUri(String path, Map<String, dynamic>? query) {
    return Uri.https(environment.baseUrl, _getFullPath(path), query);
  }

  @override
  String _getFullPath(String path) {
    return '${environment.apiPath}/$path';
  }

  @override
  Future<Map<String, String>> _getHeaders(bool isSecure) async {
    var headers = {'X-CG-APIKey': environment.apiKey, 'Content-Type': 'application/json', 'Accept': 'application/json'};

    if (isSecure) {
      var accessToken = await _secureStorage.getAccessToken();
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return headers;
  }

  @override
  Future<void> getDeviceEnrollmentStatus() {
    // TODO: implement getDeviceEnrollmentStatus
    throw UnimplementedError();
  }

  @override
  Future<void> revokeDeviceEnrollment(int deviceEnrollId) {
    // TODO: implement revokeDeviceEnrollment
    throw UnimplementedError();
  }
}
