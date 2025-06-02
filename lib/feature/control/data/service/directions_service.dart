import 'dart:convert';

import 'package:final_proj/core/api/endpoints.dart';
import 'package:http/http.dart' as http;

class DirectionsService {
  final String baseUrl = EndPoints.baseUrl;

  Future<void> controlMotor1(String d) async {
    try {
      final Map<String, dynamic> payload = {
        'direction': d,
      };
      final response = await http.post(Uri.parse('$baseUrl/motor1'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload));
      if (response.statusCode == 200) {
        print('Motor 1 controlled successfully: ${response.body}');
      } else {
        print('Failed to control Motor 1. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error controlling Motor 1: $e');
    }
  }
}
