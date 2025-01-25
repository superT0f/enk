import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class AppConfig {
  static final String? _username = dotenv.env["ENDPOINT_LOGIN"];
  static final String? _password = dotenv.env["ENDPOINT_PASSWD"];
  static String? host = dotenv.env["ENDPOINT_HOST"];
  static String? apiPath = dotenv.env["ENDPOINT_URL"];

  // Error handling for missing environment variables
  static void _validateConfig() {
    if (_username == null || _password == null || host == null || apiPath == null) {
      throw ArgumentError("Missing required environment variables.");
    }
  }

  static Uri get apiUrl {
    _validateConfig();
    return Uri.https(host!, apiPath!);
  }

  static String get basicAuth {
    _validateConfig();
    return 'Basic ${base64.encode(utf8.encode('$_username:$_password'))}';
  }
}