import 'package:bloc/bloc.dart';
import 'package:final_proj/feature/control/data/service/pump_service.dart';
import 'package:meta/meta.dart';

part 'pump_control_state.dart';

class PumpControlCubit extends Cubit<PumpControlState> {
  final PumpControlService _pumpService;
  late  bool isIrrigationOn = false;
  final bool isFertilizerOn = false;
  final bool isPesticideOn = false;


  PumpControlCubit({PumpControlService? pumpService}) 
      : _pumpService = pumpService ?? PumpControlService(),
        super(const PumpControlState());

  // Control irrigation pump
  Future<void> controlIrrigationPump({
    required bool isOn,
    required int hours,
    required int minutes,
    required int seconds,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final success = await _pumpService.controlPump(
        pumpType: 'irrigation',
        isOn: isOn,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
      
      if (success) {
        isIrrigationOn = success ;
        emit(state.copyWith(
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to control irrigation pump',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error controlling irrigation pump: $e',
      ));
    }
  }

  // Control fertilizer pump
  Future<void> controlFertilizerPump({
    required bool isOn,
    required int hours,
    required int minutes,
    required int seconds,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final success = await _pumpService.controlPump(
        pumpType: 'fertilizer',
        isOn: isOn,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
      
      if (success) {
        emit(state.copyWith(
          isFertilizerOn: isOn,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to control fertilizer pump',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error controlling fertilizer pump: $e',
      ));
    }
  }

  // Control pesticide pump
  Future<void> controlPesticidePump({
    required bool isOn,
    required int hours,
    required int minutes,
    required int seconds,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final success = await _pumpService.controlPump(
        pumpType: 'pesticide',
        isOn: isOn,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      );
      
      if (success) {
        emit(state.copyWith(
          isPesticideOn: isOn,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to control pesticide pump',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error controlling pesticide pump: $e',
      ));
    }
  }

  // Save all pump settings at once
  Future<void> saveAllPumpSettings({
    required bool isIrrigationOn,
    required int irrigationHours,
    required int irrigationMinutes,
    required int irrigationSeconds,
    required bool isFertilizerOn,
    required int fertilizerHours,
    required int fertilizerMinutes,
    required int fertilizerSeconds,
    required bool isPesticideOn,
    required int pesticideHours,
    required int pesticideMinutes,
    required int pesticideSeconds,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      // Process all three pumps in parallel
      final results = await Future.wait([
        _pumpService.controlPump(
          pumpType: 'irrigation',
          isOn: isIrrigationOn,
          hours: irrigationHours,
          minutes: irrigationMinutes,
          seconds: irrigationSeconds,
        ),
        _pumpService.controlPump(
          pumpType: 'fertilizer',
          isOn: isFertilizerOn,
          hours: fertilizerHours,
          minutes: fertilizerMinutes,
          seconds: fertilizerSeconds,
        ),
        _pumpService.controlPump(
          pumpType: 'pesticide',
          isOn: isPesticideOn,
          hours: pesticideHours,
          minutes: pesticideMinutes,
          seconds: pesticideSeconds,
        ),
      ]);
      
      final allSucceeded = results.every((result) => result);
      
      if (allSucceeded) {
        emit(state.copyWith(
          isIrrigationOn: isIrrigationOn,
          isFertilizerOn: isFertilizerOn,
          isPesticideOn: isPesticideOn,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to save some pump settings',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error saving pump settings: $e',
      ));
    }
  }
}
