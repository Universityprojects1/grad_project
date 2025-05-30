part of 'pump_control_cubit.dart';

class PumpControlState   {
  final bool isIrrigationOn;
  final bool isFertilizerOn;
  final bool isPesticideOn;
  final bool isLoading;
  final String? errorMessage;

  const PumpControlState({
    this.isIrrigationOn = false,
    this.isFertilizerOn = false,
    this.isPesticideOn = false,
    this.isLoading = false,
    this.errorMessage,
  });

  PumpControlState copyWith({
    bool? isIrrigationOn,
    bool? isFertilizerOn,
    bool? isPesticideOn,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PumpControlState(
      isIrrigationOn: isIrrigationOn ?? this.isIrrigationOn,
      isFertilizerOn: isFertilizerOn ?? this.isFertilizerOn,
      isPesticideOn: isPesticideOn ?? this.isPesticideOn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  
}