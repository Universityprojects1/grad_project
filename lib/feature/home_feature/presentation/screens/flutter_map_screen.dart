import 'package:final_proj/feature/home_feature/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapScreen extends StatelessWidget {
  const FlutterMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(context.read<WeatherCubit>().lat,
                context.read<WeatherCubit>().lon), // Center the map over London
            initialZoom: 9.2,
            onTap: (tapPosition, point) async {
              context.read<WeatherCubit>().lat = point.latitude;
              context.read<WeatherCubit>().lon = point.longitude;
              GoRouter.of(context).pop([point.latitude, point.longitude]);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ]),
    );
  }
}
