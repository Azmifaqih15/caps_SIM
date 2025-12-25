import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';
  // GANTI kalau pakai HP:
  // http://IP_KOMPUTER_KAMU:5000

  /// ================= LOGIN =================
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = data['user'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('user_id', user['id']);
      prefs.setString('username', user['username']);
      prefs.setString('full_name', user['full_name']);
      prefs.setString('role', user['role']);

      return true;
    }
    return false;
  }

  /// ================= REGISTER =================
  static Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'full_name': fullName,
      }),
    );

    return response.statusCode == 201;
  }

  /// ================= LOGOUT =================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// ================= CHECK LOGIN =================
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_id');
  }
}
