import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';

  /// GET FEED
  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/posts'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat feed');
    }
  }

  /// VERIFY POST (👍 / 👎)
  static Future<bool> verifyPost({
    required int postId,
    required int userId,
    required String type, // CONFIRM / FALSE
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/posts/$postId/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'type': type}),
    );

    return response.statusCode == 200;
  }
}
