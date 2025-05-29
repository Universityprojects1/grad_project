part of 'npk_cubit.dart';

abstract class NpkState  {
  const NpkState();
  
 
}

class NpkInitial extends NpkState {}

class NpkConnecting extends NpkState {}

class NpkConnected extends NpkState {
  final List<SensorData> readings;
  
  const NpkConnected(this.readings);
  

}

class NpkDisconnected extends NpkState {}

class NpkError extends NpkState {
  final String message;
  
  const NpkError(this.message);

}