import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';

  static Future<Map<String, dynamic>> getProfile(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/users/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal ambil profil');
    }
  }
}
