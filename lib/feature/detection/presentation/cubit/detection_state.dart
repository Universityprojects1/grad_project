part of 'detection_cubit.dart';

@immutable
sealed class DetectionState {}

final class DetectionInitial extends DetectionState {}
final class DetectionLoading extends DetectionState {}
final class DetectionSuccess extends DetectionState {
  final List<DetectionResult> results;

  DetectionSuccess(this.results);
}
final class DetectionError extends DetectionState {
  final String error;

  DetectionError(this.error);
}
