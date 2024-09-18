import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void printConsole(dynamic text) {
  if (kDebugMode) {
    print(text);
  }
}

class GlobalSnackBar {
  static final GlobalSnackBar _instance = GlobalSnackBar._internal();

  factory GlobalSnackBar() {
    return _instance;
  }

  GlobalSnackBar._internal();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String title, String subtitle, Duration duration) {
    final snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: duration,
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
