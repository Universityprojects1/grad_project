part of 'detection_camera_cubit.dart';

@immutable
sealed class DetectionCameraState {}

final class DetectionCameraInitial extends DetectionCameraState {}
final class DetectionCameraLoading extends DetectionCameraState {}
final class DetectionCameraFailure extends DetectionCameraState {
  final String message;

  DetectionCameraFailure(this.message);
}
final class DetectionCameraSuccess extends DetectionCameraState {
  final DetectionModel detectionModel;

  DetectionCameraSuccess(this.detectionModel);
}
