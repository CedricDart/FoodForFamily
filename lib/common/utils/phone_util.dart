import 'package:url_launcher/url_launcher.dart';

class PhoneUtils {
  static Future<void> callNumber(String phoneNumber) async {
    var sanitizedNumber = phoneNumber.replaceAll(' ', '');
    String phoneNumberUrl = 'tel://$sanitizedNumber';
    if (await canLaunch(phoneNumberUrl)) {
      await launch(phoneNumberUrl);
    } else {
      try {
        launch(phoneNumberUrl);
      } on Exception {
        throw 'Could not open phone number call.';
      }
    }
  }
}
