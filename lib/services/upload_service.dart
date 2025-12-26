import 'dart:io';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class UploadService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';

  static Future<bool> uploadPost({
    required File image,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final token = await AuthService.getToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/upload'),
    );

    // 🔐 JWT HEADER
    request.headers['Authorization'] = 'Bearer $token';

    // 📍 DATA LOKASI
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['address'] = address;

    // 🖼 FILE GAMBAR
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );

    var response = await request.send();
    return response.statusCode == 200;
  }
}