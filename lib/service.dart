import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://YOUR_PC_IP:3000/getStudent';

  static Future<Map<String, dynamic>?> fetchStudentDetails(String email) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          return jsonData['data'];
        }
      }
    } catch (e) {
      print('API Error: $e');
    }
    return null;
  }
}
