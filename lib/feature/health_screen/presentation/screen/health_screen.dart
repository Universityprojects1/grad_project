import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/npk_cubit.dart';
import '../widgets/element_of_nutrient.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<NpkCubit, NpkState>(
        builder: (context, state) {
          if (state is NpkInitial || state is NpkConnecting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NpkError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const Gap(16),
                  Text(
                    state.message,
                    style: AppFonts.textSemiBold20(context).copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (state is NpkDisconnected) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48),
                  const Gap(16),
                  Text(
                    "Disconnected from sensor",
                    style: AppFonts.textSemiBold20(context),
                  ),
                  const Gap(24),
                  ElevatedButton(
                    onPressed: () => context.read<NpkCubit>().connect('localhost', 8080),
                    child: const Text('Reconnect'),
                  ),
                ],
              ),
            );
          } else if (state is NpkConnected) {
            final latestData = state.readings.isNotEmpty ? state.readings.first : null;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nutrient Levels",
                  style: AppFonts.textSemiBold20(context)
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElementOfNutrient(
                      title: 'Nitrogen',
                      result: latestData != null ? '${latestData.npkData.nitrogen} ppm' : 'N/A',
                    ),
                    const SizedBox(width: 10),
                    ElementOfNutrient(
                      title: 'Phosphorus',
                      result: latestData != null ? '${latestData.npkData.phosphorus} ppm' : 'N/A',
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    ElementOfNutrient(
                      title: 'Potassium',
                      result: latestData != null ? '${latestData.npkData.potassium} ppm' : 'N/A',
                    ),
                  ],
                ),
                const Gap(20),
                Text(
                  "Soil Sensor",
                  style: AppFonts.textSemiBold20(context)
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const Gap(20),
                Row(
                  children: [
                    ElementOfNutrient(
                      title: 'Moisture',
                      result: latestData != null ? '${latestData.soilData.moisture.percentage}%' : 'N/A',
                    ),
                    const SizedBox(width: 10),
                    ElementOfNutrient(
                      title: 'Temperature',
                      result: latestData != null ? '${latestData.soilData.temperature.percentage}°C' : 'N/A',
                    ),
                  ],
                ),
              ],
            );
          }
          
          // Fallback in case of unhandled state
          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }
}
