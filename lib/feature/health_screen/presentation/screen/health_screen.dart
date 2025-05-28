import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/element_of_nutrient.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nutrient Levels",
            style: AppFonts.textSemiBold20(context)
                .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              ElementOfNutrient(
                title: 'Nitrogen',
                result: '150 ppm',
              ),
              SizedBox(width: 10),
              ElementOfNutrient(
                title: 'Phosphorus',
                result: '80 ppm',
              ),
            ],
          ),
          const Gap(20),
          const Row(
            children: [
              ElementOfNutrient(
                title: 'Potassium',
                result: '90 ppm',
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
          const Row(
            children: [
              ElementOfNutrient(
                title: 'Moisture',
                result: '30%',
              ),
              SizedBox(width: 10),
              ElementOfNutrient(
                title: 'Temperature',
                result: '25°C',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
