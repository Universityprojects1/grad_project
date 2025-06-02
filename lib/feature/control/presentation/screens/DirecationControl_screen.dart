import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/feature/control/presentation/cubit_motors/motors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../data/service/directions_service.dart';
import 'control_screen.dart';

class DirecationcontrolScreen extends StatelessWidget {
  const DirecationcontrolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width * 0.5;
    return SingleChildScrollView(
      child: Column(
        children: [
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Motor 1 ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      CustomButton(
                        onTap: () {
                          context.read<MotorsCubit>().controlMotor1("front");
                        },
                        text: "Front",
                        color: AppColor.colorButtonNew,
                        width: width,
                        colorOfButton: AppColor.blackColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          context.read<MotorsCubit>().controlMotor1("back");
                        },
                        text: "Back",
                        color: AppColor.colorButtonNew,
                        width: width,
                        colorOfButton: AppColor.blackColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Motor 2 ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      CustomButton(
                        text: "Left",
                        color: AppColor.colorButtonNew,
                        width: width,
                        colorOfButton: AppColor.blackColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Right",
                        color: AppColor.colorButtonNew,
                        width: width,
                        colorOfButton: AppColor.blackColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const PumpControlScreen(),
        ],
      ),
    );
  }
}
