import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/npk_model.dart';

class NpkSocketService {
  WebSocketChannel? _channel;
  final _connectionStatusController = StreamController<bool>.broadcast();
  final _dataController = StreamController<SensorData>.broadcast();
  
  // Getter for the connection status stream
  Stream<bool> get connectionStatus => _connectionStatusController.stream;
  
  // Getter for the sensor data stream
  Stream<SensorData> get SensorDataStream => _dataController.stream;
  
  // Connect to WebSocket server
  Future<void> connect(String host, int port) async {
    try {
      final uri = Uri.parse('ws://$host:$port');
      _channel = WebSocketChannel.connect(uri);
      
      // Listen for incoming data
      _channel!.stream.listen(
        (dynamic data) {
          try {
            // Convert single quotes to double quotes if the data is a string
            if (data is String) {
              // Replace single quotes with double quotes for proper JSON format
              data = data.replaceAll("'", "\"");
              
              // Try to parse the JSON data
              final Map<String, dynamic> jsonData = jsonDecode(data);
              final sensorData = SensorData.fromJson(jsonData);
              _dataController.add(sensorData);
            }
          } catch (e) {
            print('Error parsing NPK data: $e');
            // Don't emit anything if parsing fails
          }
        },
        onDone: () {
          _connectionStatusController.add(false);
        },
        onError: (error) {
          print('WebSocket error: $error');
          _connectionStatusController.add(false);
        },
        cancelOnError: false,
      );
      
      _connectionStatusController.add(true);
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      _connectionStatusController.add(false);
      rethrow;
    }
  }
  
  // Disconnect from WebSocket server
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _connectionStatusController.add(false);
  }
  
  // Dispose resources
  void dispose() {
    _channel?.sink.close();
    _connectionStatusController.close();
    _dataController.close();
  }
}