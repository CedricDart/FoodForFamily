import 'app_exception.dart';

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, 'Error during communication: ');
}
