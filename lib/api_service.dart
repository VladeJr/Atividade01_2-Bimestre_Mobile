import 'package:http/http.dart' as http;

abstract class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse('$baseUrl/$endpoint'));
  }

  Future<http.Response> post(String endpoint, String body) {
    return http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  Future<http.Response> delete(String endpoint) {
    return http.delete(Uri.parse('$baseUrl/$endpoint'));
  }
}
