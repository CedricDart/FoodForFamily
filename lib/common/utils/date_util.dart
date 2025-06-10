import 'package:intl/intl.dart';

class DateUtil {
  static DateTime parse(String? input) {
    final format = DateFormat('EEE MMM d hh:mm:ss yyyy', 'en_US');
    input = input?.replaceAll('CEST ', '');
    try {
      return input == null ? DateTime.now() : format.parse(input);
    } catch (_) {
      return DateTime.now();
    }
  }
}
