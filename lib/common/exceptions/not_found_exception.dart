import 'app_exception.dart';

class NotFoundException extends AppException {
  NotFoundException() : super('404', 'Not found');
}
