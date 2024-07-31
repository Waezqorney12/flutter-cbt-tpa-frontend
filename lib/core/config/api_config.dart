import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final baseUrl = dotenv.env['baseUrl'];
  static final tokenKey = dotenv.env['tokenKey'];
}
