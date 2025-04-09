import 'package:bloc/bloc.dart';
import 'package:final_proj/feature/home_feature/data_source/data/weather_remote.dart';
import 'package:final_proj/feature/home_feature/data_source/model/weather_model.dart';
import 'package:final_proj/feature/home_feature/data_source/repo/weather_repo.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  WeatherRepo weatherRepo = WeatherRepo(weatherRemote: WeatherRemote());
  double lat = 0;
  double lon = 0;
  getWeather() async {
    emit(WeatherLoading());
    var res = await weatherRepo.getWeather(lat, lon);
    res.fold(
      (left) => emit(WeatherFailure(left)),
      (right) => emit(WeatherSuccess(right)),
    );
  }
}
