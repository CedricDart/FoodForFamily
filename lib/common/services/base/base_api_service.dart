import 'dart:convert';

import 'package:food_for_family/common/components/common_api_exception_presenter.dart';
import 'package:food_for_family/common/config/environment.dart';
import 'package:food_for_family/common/exceptions/bad_request_exception.dart';
import 'package:food_for_family/common/exceptions/fetch_data_exception.dart';
import 'package:food_for_family/common/exceptions/not_found_exception.dart';
import 'package:food_for_family/common/exceptions/service_unavailable_exception.dart';
import 'package:food_for_family/common/exceptions/unauthorized_exception.dart';
import 'package:food_for_family/common/models/base/serializable.dart';
import 'package:food_for_family/common/models/web_service/generic_request.dart';
import 'package:food_for_family/common/services/base/base_service.dart';
import 'package:food_for_family/common/services/performance_service.dart';
import 'package:food_for_family/common/services/request_queue.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiService extends BaseService {
  Environment get environment {
    return locator<Environment>();
  }

  PerformanceService get performance {
    return locator<PerformanceService>();
  }

  GenericRequest? _lastRequest;

  Future<dynamic> get(Uri uri, Map<String, String> headers, Map<String, dynamic>? query, String traceName) async {
    _lastRequest = GenericRequest(method: RequestMethod.get, uri: uri, headers: headers, query: query, traceName: traceName);

    dynamic responseJson;

    logger.debug(uri);
    logger.debug(headers);
    logger.debug(query ?? '');

    var trace = await performance.addTrace(traceName);
    await performance.startTrace(trace);
    var response = await RequestQueue.queue.add(() => http.get(uri, headers: headers));
    await performance.stopTrace(trace);
    responseJson = _returnResponse(response);

    return responseJson;
  }

  Future<dynamic> post(Uri uri, Map<String, String> headers, Serializable request, String traceName) async {
    _lastRequest = GenericRequest(method: RequestMethod.post, uri: uri, headers: headers, body: request, traceName: traceName);

    dynamic responseJson;

    logger.debug(uri);
    logger.debug(headers);
    logger.debug(request.toJson());

    var trace = await performance.addTrace(traceName);
    await performance.startTrace(trace);
    final response = await RequestQueue.queue.add(() => http.post(uri, headers: headers, body: jsonEncode(request.toJson())));
    await performance.stopTrace(trace);
    responseJson = _returnResponse(response);
    return responseJson;
  }

  Future<dynamic> delete(
    Uri uri,
    Map<String, String> headers,
    Serializable request,
    String traceName,
  ) async {
    _lastRequest = GenericRequest(method: RequestMethod.delete, uri: uri, headers: headers, body: request, traceName: traceName);

    dynamic responseJson;

    logger.debug(uri);
    logger.debug(headers);
    logger.debug(request.toJson());

    var trace = await performance.addTrace(traceName);
    await performance.startTrace(trace);
    final response = await RequestQueue.queue.add(() => http.get(uri, headers: headers));
    await performance.stopTrace(trace);
    responseJson = _returnResponse(response);
    return responseJson;
  }

  Future<dynamic> retry() {
    if (_lastRequest != null) {
      logger.info('Retrying last request.');

      switch (_lastRequest!.method) {
        case RequestMethod.get:
          return get(_lastRequest!.uri, _lastRequest!.headers, _lastRequest!.query, _lastRequest!.traceName);
        case RequestMethod.post:
          return post(_lastRequest!.uri, _lastRequest!.headers, _lastRequest!.body!, _lastRequest!.traceName);
        case RequestMethod.delete:
          return delete(_lastRequest!.uri, _lastRequest!.headers, _lastRequest!.body!, _lastRequest!.traceName);
      }
    }

    logger.info('Cannot find a last request to retry.');

    return Future.value(null);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        var body = response.body.toString();
        dynamic responseJson;
        if (body.isNotEmpty) {
          responseJson = json.decode(body);
        } else {
          responseJson = json.decode('{}');
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw NotFoundException();
      case 500:
        throw ServiceUnavailableException(response.body.toString());
      default:
        CommonApiExceptionPresenter.present();
        throw FetchDataException('Error occurred: ${response.statusCode}');
    }
  }
}
