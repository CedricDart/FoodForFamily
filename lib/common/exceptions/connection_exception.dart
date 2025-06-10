import 'app_exception.dart';

class InternetConnectionException extends AppException {
  InternetConnectionException(message)
      : super(message, 'No internet connection: ');
}
