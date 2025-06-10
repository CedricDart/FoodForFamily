import 'app_exception.dart';

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException(message) : super(message, 'Service unavailable');
}
