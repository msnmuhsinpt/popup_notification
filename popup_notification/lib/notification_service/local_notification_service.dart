import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');

    IOSInitializationSettings iosInitializationSettings =
        const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _localNotificationService.initialize(settings,
        onSelectNotification: onSelectNotification);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            'popuppushnotification', 'popuppushnotification',
            channelDescription: 'popuppushnotification',
            priority: Priority.high,
            importance: Importance.max,
        );

    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails,
    );
  }

  //normal notification

  Future<void> showNotification(
    int id,
    String title,
    String body,
  ) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {}

void onSelectNotification(String? payload) {
  print('local notification');
}
