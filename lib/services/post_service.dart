import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class PostService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';

  /// ================= GET FEED (PUBLIC) =================
  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/posts'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat feed');
    }
  }

  /// ================= VERIFY POST (JWT) =================
  static Future<bool> verifyPost({
    required int postId,
    required String type, // CONFIRM / FALSE
  }) async {
    final token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/posts/$postId/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'type': type,
      }),
    );

    return response.statusCode == 200;
  }
}