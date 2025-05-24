part of 'detection_cubit.dart';

@immutable
sealed class DetectionState {}

final class DetectionInitial extends DetectionState {}

final class DetectionLoading extends DetectionState {}

final class DetectionSuccess extends DetectionState {
  final DetectionModel detectionModel;

  DetectionSuccess(this.detectionModel);
}

final class DetectionError extends DetectionState {
  final String message;

  DetectionError(this.message);
}
