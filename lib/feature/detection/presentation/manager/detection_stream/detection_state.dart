part of 'detection_cubit.dart';

@immutable
sealed class DetectionState {}

final class DetectionInitial extends DetectionState {}

final class DetectionStreamLoading extends DetectionState {}

final class DetectionStreamSuccess extends DetectionState {
  final ModelDetection detectionModel;

  DetectionStreamSuccess(this.detectionModel);
}

final class DetectionStreamError extends DetectionState {
  final String message;

  DetectionStreamError(this.message);
}
