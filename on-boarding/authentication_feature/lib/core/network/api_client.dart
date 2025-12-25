import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;
  final Map<String, dynamic> defaultHeaders;
  final Future<String?> Function()? getToken;

  ApiClient({
    required this.client,
    required this.baseUrl,
    this.defaultHeaders = const {
      "Content-Type": "application/json",
    },
    this.getToken,
  });

  Future<Map<String, String>> _buildHeaders({bool auth = false}) async {
    final headers = Map<String, String>.from(defaultHeaders);

    if (auth && getToken != null) {
      final token = await getToken!();
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    return headers;
  }

  Future<dynamic> get(String endpoint, {bool auth = false}) async {
    final response = await client.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await _buildHeaders(auth: auth),
    );
    return _handleResponse(response);
  }

  Future<dynamic> post(
    String endpoint,
    dynamic body, {
    bool auth = false,
  }) async {
    final response = await client.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await _buildHeaders(auth: auth),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(
    String endpoint,
    dynamic body, {
    bool auth = false,
  }) async {
    final response = await client.put(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await _buildHeaders(auth: auth),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(
    String endpoint, {
    bool auth = false,
  }) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await _buildHeaders(auth: auth),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 204) {
      return null;
    }

    throw Exception(
      "API Error ${response.statusCode}: ${response.body}",
    );
  }

}