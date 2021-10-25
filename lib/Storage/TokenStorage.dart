// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final storage = FlutterSecureStorage();
  

  static Future setToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    await storage.read(key: "token");
  }
  
}