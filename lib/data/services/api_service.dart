import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://mocki.io/v1";

  Future<List<dynamic>> fetchDeals() async {
    final response = await http.get(Uri.parse("$baseUrl/your-api-endpoint"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load deals");
    }
  }
}
