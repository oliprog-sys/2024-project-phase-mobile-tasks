import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient({required this.client, required this.baseUrl});

  static const defaultHeaders = {"Content-Type": "application/json"};

  Future<dynamic> get(String endpoint) async {
    final response = await client.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: defaultHeaders,
    );
    return _handle(response);
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await client.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
    return _handle(response);
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    final response = await client.put(
      Uri.parse("$baseUrl/$endpoint"),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
    return _handle(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/$endpoint"),
      headers: defaultHeaders,
    );
    return _handle(response);
  }

  dynamic _handle(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 204) return null;

    throw Exception("API Error ${response.statusCode}: ${response.body}");
  }
}
