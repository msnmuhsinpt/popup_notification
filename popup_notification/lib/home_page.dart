import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
    //foreground

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
}
