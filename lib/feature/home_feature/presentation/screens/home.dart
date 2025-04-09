import 'package:final_proj/config/routes/routes.dart';
import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:final_proj/feature/home_feature/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cache/storage_token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageToken storageToken = StorageToken();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              const Gap(30),
              Text(
                state.weatherResponse.name,
                style: AppFonts.textRegular16(context).copyWith(
                    fontSize: 40,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${state.weatherResponse.main.tempMax.toString()}°C",
                style: AppFonts.textRegular16(context)
                    .copyWith(fontSize: 70, color: AppColor.blackColor),
              ),
              Text(
                state.weatherResponse.weather[0].description,
                style: AppFonts.textRegular16(context).copyWith(
                    fontSize: 30,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Cloud Coverage: ${state.weatherResponse.clouds.all}%",
                style: AppFonts.textRegular16(context).copyWith(
                    fontSize: 24,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Humidity: ${state.weatherResponse.main.humidity}%",
                style: AppFonts.textRegular16(context).copyWith(
                    fontSize: 24,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomButton(
                    onTap: () async {
                      var result = await GoRouter.of(context)
                          .push(AppRoute.flutterMapScreen);
                      if (result != null &&
                          result is List &&
                          result.length == 2) {
                        final lat = result[0] as double;
                        final lon = result[1] as double;
                        context.read<WeatherCubit>().getWeather(lat, lon);
                      }
                    },
                    text: AppString.selectLocation,
                    color: AppColor.colorButton2),
              )
            ],
          );
        } else if (state is WeatherFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.error),
            ],
          );
        } else if (state is WeatherLoading) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
