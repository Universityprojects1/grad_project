import 'package:animate_do/animate_do.dart';
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
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/cache/storage_token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageToken storageToken = StorageToken();

  List<Color> _getTemperatureGradient(double temperature) {
    if (temperature <= 10) {
      return [Colors.blue.shade700, Colors.blue.shade200];
    } else if (temperature > 10 && temperature <= 25) {
      return [Colors.green.shade600, Colors.green.shade200];
    } else if (temperature > 25 && temperature <= 35) {
      return [Colors.orange.shade700, Colors.orange.shade300];
    } else {
      return [Colors.red.shade800, Colors.red.shade400];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * .2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: _getTemperatureGradient(
                          state.weatherResponse.main.tempMax),
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                ),
                const Gap(30),
                FadeInUp(
                   duration: const Duration(milliseconds: 900),
                   curve: Curves.linearToEaseOut,
                  child: Column(
                    children: [
                      Text(
                        state.weatherResponse.name,
                        style: AppFonts.textRegular16(context).copyWith(
                            fontSize: 22,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${state.weatherResponse.main.tempMax.toString()}°C",
                        style: AppFonts.textRegular16(context).copyWith(
                            fontSize: 32,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(16)),
                                      border:
                                          Border.all(color: AppColor.borderColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cloud Coverage",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const Gap(15),
                                        Text(
                                          "${state.weatherResponse.clouds.all}%",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 24,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(16)),
                                      border:
                                          Border.all(color: AppColor.borderColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const Gap(15),
                                        Text(
                                          "${state.weatherResponse.main.humidity}%",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 24,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(16)),
                                      border:
                                          Border.all(color: AppColor.borderColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Wind Speed",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const Gap(15),
                                        Text(
                                          "${state.weatherResponse.wind.speed} km/h",
                                          style: AppFonts.textRegular16(context)
                                              .copyWith(
                                                  fontSize: 24,
                                                  color: AppColor.blackColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                            onTap: () async {
                              var result = await GoRouter.of(context).push(
                                  AppRoute.flutterMapScreen,
                                  extra: LatLng(context.read<WeatherCubit>().lat,
                                      context.read<WeatherCubit>().lon));
                              if (result != null &&
                                  result is List &&
                                  result.length == 2) {
                                final lat = result[0] as double;
                                final lon = result[1] as double;
                                context.read<WeatherCubit>().getWeather(lat, lon);
                              }
                            },
                            colorOfButton: AppColor.blackColor,
                            text: AppString.selectLocation,
                            color: AppColor.colorButtonNew),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (state is WeatherFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity,),
              Text(state.error),
            ],
          );
        } else if (state is WeatherLoading) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.fourRotatingDots(
                    color: AppColor.primaryColor,
                    size: 50,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
