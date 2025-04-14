import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/feature/control/presentation/screens/date_and_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/component/timer_manager.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateAndTimeScreen(
                        title: AppString.irrigation,
                        customTimer:
                            TimerManager().getTimer(AppString.irrigation)),
                  ));
            },
            text: AppString.irrigation,
            color: AppColor.primaryColor,
            height: 70,
          ),
          const Gap(15),
          CustomButton(
            text: AppString.fertilizer,
            color: AppColor.colorButton2,
            height: 70,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateAndTimeScreen(
                      title: AppString.irrigation,
                      customTimer:
                          TimerManager().getTimer(AppString.fertilizer),
                    ),
                  ));
            },
          ),
          const Gap(15),
          CustomButton(
            text: AppString.pesticide,
            color: AppColor.colorButton3,
            height: 70,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateAndTimeScreen(
                        title: AppString.irrigation,
                        customTimer:
                            TimerManager().getTimer(AppString.pesticide)),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
