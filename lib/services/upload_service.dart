import 'dart:io';
import 'package:http/http.dart' as http;

class UploadService {
  static const String baseUrl =
      'https://unexchangeable-unstern-robt.ngrok-free.dev';

  static Future<bool> uploadPost({
    required File image,
    required double latitude,
    required double longitude,
    required String address,
    required int userId,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/api/upload'),
    );

    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.fields['address'] = address;
    request.fields['user_id'] = userId.toString();

    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();
    return response.statusCode == 200;
  }
}
