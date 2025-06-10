import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initializeNotifications() async {
    // Request notification permissions for iOS
    await _requestPermissions();

    // Get the FCM token for this device
    String? token = await _messaging.getToken();
    print("FCM Token: $token");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a message in the foreground: ${message.notification?.title}");
    });

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened: ${message.notification?.title}");
    });
  }

  Future<void> _requestPermissions() async {
    // Check notification permission status
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      // Request the permission if it's not granted
      await Permission.notification.request();
    }

    // For iOS, request specific permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Notification permission: ${settings.authorizationStatus}");
  }
}
