import 'dart:convert';

import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/tools.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum KeyStorage { user, token }

class LocalServices {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveUserResponseModel(UserModel userModel) async {
    final jsonUserModel = userModel.toJson();
    await _secureStorage
        .write(key: KeyStorage.user.toString(), value: jsonEncode(jsonUserModel))
        .then((value) async {
      printConsole('success saved user');
      // printConsole(jsonUserModel);
    });
  }

  Future<UserModel?> getResponseUserModel() async {
    final jsonString = await _secureStorage.read(key: KeyStorage.user.toString());
    if (jsonString == null) {
      return null;
    }
    final jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  Future<void> saveToken(String id) async {
    await _secureStorage.write(key: KeyStorage.token.toString(), value: id).then((value) {
      printConsole('token saved');
    });
  }

  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: KeyStorage.token.toString());
    if (token == null) {
      return null;
    }

    return token;
  }

  Future<void> deleteAllData() async {
    await _secureStorage.delete(key: KeyStorage.token.toString()).then((value) {
      printConsole('delete token...');
    });
    await _secureStorage.delete(key: KeyStorage.user.toString()).then((value) {
      printConsole('delete user...');
    });
  }
}
