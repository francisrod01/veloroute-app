import 'dart:convert';
import 'package:http/http.dart' as http;

class TransportDataClient {
  final String baseUrl;
  final http.Client httpClient;

  TransportDataClient({
    required this.baseUrl,
    http.Client? client,
  }) : httpClient = client ?? http.Client();

  // Fetches schedules filtered by route_id using PostgREST syntax
  Future<List<dynamic>> fetchSchedules(String routeId) async {
    final url = Uri.parse('$baseUrl/schedules?route_id=eq.$routeId');

    try {
      final response = await httpClient.get(
        url,
        headers: { 'Content-Type': 'application/json' },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }
}