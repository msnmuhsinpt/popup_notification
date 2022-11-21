import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:popup_notification/home_page.dart';

import 'notificationservice/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LocalNotificationService service;

  @override
  void initState() {
    super.initState();
    service = LocalNotificationService();
    service.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
