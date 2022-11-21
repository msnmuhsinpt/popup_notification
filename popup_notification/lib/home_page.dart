import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:popup_notification/notificationservice/local_notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    try {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print('could not get token');
      print(e.toString());
    }
    if (_deviceToken != null) {
      print('-------Device Token Is-------------${_deviceToken.toString()}');
    }
    return _deviceToken;
  }

  @override
  void initState() {
    super.initState();

    _saveDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text('Device Token'),
          ),
        ],
      ),
    );
  }
}
