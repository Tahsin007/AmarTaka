import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants{
  static const String appName = 'AmarTaka';
  static const String version = '1.0.0';
  static String? apiBaseUrl = dotenv.env['API_URL'];
}