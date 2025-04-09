part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherResponse weatherResponse;

  WeatherSuccess(this.weatherResponse);
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);
}
