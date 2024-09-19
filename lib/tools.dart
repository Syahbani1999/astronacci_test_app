import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

void printConsole(dynamic text) {
  if (kDebugMode) {
    print(text);
  }
}

String hashPassword(String password) {
  // Convert the password to bytes
  var bytes = utf8.encode(password);

  // Hash the bytes using SHA-256
  var digest = sha256.convert(bytes);

  // Return the hashed password as a string
  return digest.toString();
}

String getInitials(String value) =>
    value.isNotEmpty ? value.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join() : '';

String capitalizeFirstCharacterOfEachWord(String text) {
  if (text.isEmpty) return text;

  List<String> words = text.split(' ');
  List<String> capitalizedWords = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      String capitalizedWord = word[0].toUpperCase() + word.substring(1);
      capitalizedWords.add(capitalizedWord);
    }
  }

  return capitalizedWords.join(' ');
}

class GlobalSnackBar {
  static final GlobalSnackBar _instance = GlobalSnackBar._internal();

  factory GlobalSnackBar() {
    return _instance;
  }

  GlobalSnackBar._internal();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String title, String subtitle, Duration duration) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      duration: duration,
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
