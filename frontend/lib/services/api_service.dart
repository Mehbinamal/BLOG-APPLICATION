import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/auth_manager.dart';
import '../models/post.dart';

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

  static Future<List<Post>> getPosts() async {
    final token = await AuthManager.getToken();
    if (token == null) {
      throw Exception('No authentication token available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/posts/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  static Future<Post> createPost(String title, String content) async {
    final token = await AuthManager.getToken();
    if (token == null) {
      throw Exception('No authentication token available');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/create-post/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Post.fromJson(data);
    } else {
      throw Exception('Failed to create post: \\${response.statusCode}');
    }
  }
}
