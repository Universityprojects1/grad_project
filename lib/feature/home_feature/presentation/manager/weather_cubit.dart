import 'package:bloc/bloc.dart';
import 'package:final_proj/core/utils/location.dart';
import 'package:final_proj/feature/home_feature/data_source/data/weather_remote.dart';
import 'package:final_proj/feature/home_feature/data_source/model/weather_model.dart';
import 'package:final_proj/feature/home_feature/data_source/repo/weather_repo.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  LocationService locationService = LocationService();
  WeatherRepo weatherRepo = WeatherRepo(weatherRemote: WeatherRemote());
  double lat = 0;
  double lon = 0;

  void updateLocation() async {
    await locationService.checkAndRequestLocationService();
    await locationService.checkAndRequestLocationPermission();
    var loc = await locationService.location.getLocation();
    lat = loc.latitude!;
    lon = loc.longitude!;
    getWeather(lat, lon);
  }

  getWeather(double lat, double lon) async {
    emit(WeatherLoading());
    var res = await weatherRepo.getWeather(lat, lon);
    res.fold(
      (left) => emit(WeatherFailure(left)),
      (right) => emit(WeatherSuccess(right)),
    );
  }
}
