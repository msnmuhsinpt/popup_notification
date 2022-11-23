import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:popup_notification/home_page.dart';
import 'package:popup_notification/notification_service/local_notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Message Inside Background>>>$message");
  print(message.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
  //foreground
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage remoteMessage) {
      String? title = remoteMessage.data['title'];
      String? description = remoteMessage.data['dody'];
      showSimpleNotification(
          Text(
            title.toString(),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          subtitle: Text(
            description.toString(),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          elevation: 0,
          trailing: SizedBox(
            width: 150,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '1 Mit',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '5 Mit',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          background: Colors.grey.shade400);
    },
  );
  //background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    String? title = remoteMessage.data['title'];
    String? description = remoteMessage.data['dody'];
    log("message foreground $title");

    showSimpleNotification(
        const Text("this is a message from simple notification"),
        background: Colors.green);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LocalNotificationService service;

  /* Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    log('BackGround Notification');
    Text(message.data['title']);
  }*/

  @override
  void initState() {
    super.initState();
    service = LocalNotificationService();
    service.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
