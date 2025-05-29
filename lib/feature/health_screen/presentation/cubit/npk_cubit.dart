import 'dart:async';

import 'package:final_proj/feature/health_screen/data/model/npk_model.dart';
import 'package:final_proj/feature/health_screen/data/service/npk_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'npk_state.dart';

class NpkCubit extends Cubit<NpkState> {
  final NpkSocketService _npkSocketService;
  StreamSubscription? _npkDataSubscription;
  StreamSubscription? _connectionSubscription;
  
  // Keep a list of recent readings for display in the UI
  final List<SensorData> _recentReadings = [];
  static const int maxReadings = 10;
  
  NpkCubit(this._npkSocketService) : super(NpkInitial()) {
    // Start listening to connection status changes
    _connectionSubscription = _npkSocketService.connectionStatus.listen((connected) {
      if (connected) {
        _startListeningToData();
        emit(NpkConnected([]));
      } else {
        emit(NpkDisconnected());
      }
    });
  }
  
  // Connect to WebSocket server
  Future<void> connect(String host, int port) async {
    emit(NpkConnecting());
    
    try {
      await _npkSocketService.connect(host, port);
      // The connection status listener will handle the state changes
    } catch (e) {
      emit(NpkError('Failed to connect: $e'));
    }
  }
  
  // Disconnect from WebSocket server
  Future<void> disconnect() async {
    await _npkSocketService.disconnect();
    _recentReadings.clear();
    emit(NpkDisconnected());
  }
  
  // Start listening to NPK data from the WebSocket
  void _startListeningToData() {
    _npkDataSubscription?.cancel();
    _npkDataSubscription = _npkSocketService.SensorDataStream.listen(_handleNewData);
  }
  
  // Handle new NPK data
  void _handleNewData(SensorData data) {
    // Add to recent readings list and maintain maximum size
    _recentReadings.insert(0, data);
    if (_recentReadings.length > maxReadings) {
      _recentReadings.removeLast();
    }
    
    emit(NpkConnected(List.unmodifiable(_recentReadings)));
  }
  
  @override
  Future<void> close() {
    _npkDataSubscription?.cancel();
    _connectionSubscription?.cancel();
    _npkSocketService.dispose();
    return super.close();
  }
}

// NPK State
