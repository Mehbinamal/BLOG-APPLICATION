import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/auth_manager.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await AuthManager.saveToken(token);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signup(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
