import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/directions_service.dart';

part 'motors_state.dart';

class MotorsCubit extends Cubit<MotorsState> {
  MotorsCubit() : super(MotorsInitial());
  final DirectionsService _directionsService = DirectionsService();

  Future<void> controlMotor1(String direction) async {
    await _directionsService.controlMotor1(direction);
  }
  Future<void> controlMotor2(String direction) async {
    await _directionsService.controlMotor2(direction);
  }
}
