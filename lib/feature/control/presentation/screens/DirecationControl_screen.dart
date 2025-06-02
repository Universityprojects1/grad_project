import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/feature/control/presentation/cubit_motors/motors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../data/service/directions_service.dart';
import 'control_screen.dart';

class DirecationcontrolScreen extends StatefulWidget {
  const DirecationcontrolScreen({super.key});

  @override
  State<DirecationcontrolScreen> createState() => _DirecationcontrolScreenState();
}

class _DirecationcontrolScreenState extends State<DirecationcontrolScreen> {
  late int count = 1200 ;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
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
                        'Motor For Arm',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      CustomButton(
                        onTap: () async {
                         await context.read<MotorsCubit>().controlMotor2("front");
                          count -= 300 ;
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
                        onTap: () async {
                          if (count < 1800){
                            await context.read<MotorsCubit>().controlMotor2("back");
                            count += 300 ;
                          }

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
                        'Motor For Soil',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      CustomButton(
                        text: "Left",
                        onTap: () {
                          context.read<MotorsCubit>().controlMotor1("left");
                        },
                        color: AppColor.colorButtonNew,
                        width: width,
                        colorOfButton: AppColor.blackColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () {
                          context.read<MotorsCubit>().controlMotor1("right");
                        },
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
