import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:final_proj/core/api/end_points.dart';
import 'package:final_proj/feature/home_feature/data_source/model/weather_model.dart';

class WeatherRemote {
  final Dio _dio = Dio();

  Future<Either<String, WeatherResponse>> getWeather(
      double lat, double lon) async {
    try {
      final response = await _dio.get(EndPoints.weatherApi, queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': EndPoints.apiKey,
        'units': 'metric',
        'lang': 'en',
      });

      return Right(WeatherResponse.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
