import 'dart:convert';
import 'package:final_proj/core/api/endpoints.dart';
import 'package:http/http.dart' as http;

class PumpControlService {
  final String baseUrl = EndPoints.baseUrl;

  // Control pump with state and timer settings in same API call
  Future<bool> controlPump({
    required String pumpType,
    required bool isOn,
    required int hours,
    required int minutes,
    required int seconds,
  }) async {
    try {
      // If turning off, send a stop command instead of regular control
      final endpoint = '$baseUrl/$pumpType/control';
      final totalTimeInSeconds = (hours * 3600) + (minutes * 60) + seconds;

      final Map<String, dynamic> payload = {
        'state': isOn,
        'duration': totalTimeInSeconds,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
      };

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["state"];
      } else {
        print(
            'Failed to control $pumpType. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error controlling $pumpType: $e');
      return false;
    }
  }
}
