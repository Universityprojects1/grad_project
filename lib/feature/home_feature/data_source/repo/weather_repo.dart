import 'package:either_dart/either.dart';
import 'package:final_proj/feature/home_feature/data_source/data/weather_remote.dart';
import 'package:final_proj/feature/home_feature/data_source/model/weather_model.dart';

class WeatherRepo {
  WeatherRemote weatherRemote;

  WeatherRepo({required this.weatherRemote});

  Future<Either<String, WeatherResponse>> getWeather(
      double lat, double lon) async {
    return await weatherRemote.getWeather(lat, lon);
  }
}
