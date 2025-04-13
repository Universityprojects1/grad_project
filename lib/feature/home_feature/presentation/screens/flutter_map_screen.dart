import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/home_feature/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapScreen extends StatelessWidget {
  const FlutterMapScreen({super.key, required this.latLng});

  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(latLng.latitude, latLng.longitude),
            initialZoom: 9.2,
            onTap: (tapPosition, point) async {
              context.read<WeatherCubit>().lat = point.latitude;
              context.read<WeatherCubit>().lon = point.longitude;
              GoRouter.of(context).pop([point.latitude, point.longitude]);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: AppString.apiOfMap,
              userAgentPackageName: 'com.example.app',
            ),
          ]),
    );
  }
}
