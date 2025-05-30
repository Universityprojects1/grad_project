import 'dart:convert';
import 'package:final_proj/core/api/endpoints.dart';
import 'package:http/http.dart' as http;

class PumpControlService {
  final String baseUrl = EndPoints.baseUrl; // Replace with your actual hardware API endpoint

  // Control pump with state and timer settings in same API call
  Future<bool> controlPump({
    required String pumpType,
    required bool isOn,
    required int hours,
    required int minutes,
    required int seconds,
  }) async {
    try {
      final totalTimeInSeconds = (hours * 3600) + (minutes * 60) + seconds;
      
      final response = await http.post(
        Uri.parse('$baseUrl/$pumpType/control'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'state': isOn,
          'duration': totalTimeInSeconds,
          'hours': hours,
          'minutes': minutes,
          'seconds': seconds,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to control $pumpType. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error controlling $pumpType: $e');
      return false;
    }
  }
}