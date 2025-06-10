import 'package:food_for_family/common/services/logger_service.dart';
import 'package:food_for_family/common/utils/locator.dart';

abstract class BaseService {
  LoggerService get logger {
    return locator<LoggerService>();
  }
}
