import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DirecationcontrolScreen extends StatelessWidget {
  const DirecationcontrolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Motor 1 ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        CustomButton(
          text: "Front",
          color: AppColor.colorButtonNew,
          width: width,
          colorOfButton: AppColor.blackColor,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: "Back",
          color: AppColor.colorButtonNew,
          width: width,
          colorOfButton: AppColor.blackColor,
        ),
        const SizedBox(
          height: 30,
        ),
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
    );
  }
}
