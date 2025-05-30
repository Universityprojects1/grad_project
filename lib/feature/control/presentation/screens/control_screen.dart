import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/section_of_action.dart';

class PumpControlScreen extends StatefulWidget {
  const PumpControlScreen({super.key});

  @override
  State<PumpControlScreen> createState() => _PumpControlScreenState();
}

class _PumpControlScreenState extends State<PumpControlScreen> {
  final TextEditingController controllerSecondsIrrigation =
      TextEditingController();
  final TextEditingController controllerMinutesIrrigation =
      TextEditingController();
  final TextEditingController controllerHoursIrrigation =
      TextEditingController();
  final TextEditingController controllerSecondsFertilizer =
      TextEditingController();
  final TextEditingController controllerMinutesFertilizer =
      TextEditingController();
  final TextEditingController controllerHoursFertilizer =
      TextEditingController();
  final TextEditingController controllerSecondsPesticide =
      TextEditingController();
  final TextEditingController controllerMinutesPesticide =
      TextEditingController();
  final TextEditingController controllerHoursPesticide =
      TextEditingController();
  final FocusNode focusNodeSecondsIrrigation = FocusNode();
  final FocusNode focusNodeMinutesIrrigation = FocusNode();
  final FocusNode focusNodeHoursIrrigation = FocusNode();
  final FocusNode focusNodeSecondsFertilizer = FocusNode();
  final FocusNode focusNodeMinutesFertilizer = FocusNode();
  final FocusNode focusNodeHoursFertilizer = FocusNode();
  final FocusNode focusNodeSecondsPesticide = FocusNode();
  final FocusNode focusNodeMinutesPesticide = FocusNode();
  final FocusNode focusNodeHoursPesticide = FocusNode();
  String titleIrrigation = AppString.irrigation;
  String titleFertilizer = AppString.fertilizer;
  String titlePesticide = AppString.pesticide;
  bool isOnPesticide = false;
  bool isOnFertilizer = false;
  bool isOnIrrigation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [

              const Gap(20),
              SectionOfAction(
                  controllerSeconds: controllerSecondsIrrigation,
                  controllerMinutes: controllerMinutesIrrigation,
                  controllerHours: controllerHoursIrrigation,
                  focusNodeSeconds: focusNodeSecondsIrrigation,
                  focusNodeMinutes: focusNodeMinutesIrrigation,
                  focusNodeHours: focusNodeHoursIrrigation,
                  title: titleIrrigation,
                  isOn: isOnIrrigation,
                  onSwitchChanged: (bool value) {
                    setState(() {
                      isOnIrrigation = value;
                    });
                  }),
              const Gap(20),
              SectionOfAction(
                  controllerSeconds: controllerSecondsFertilizer,
                  controllerMinutes: controllerMinutesFertilizer,
                  controllerHours: controllerHoursFertilizer,
                  focusNodeSeconds: focusNodeSecondsFertilizer,
                  focusNodeMinutes: focusNodeMinutesFertilizer,
                  focusNodeHours: focusNodeHoursFertilizer,
                  title: titleFertilizer,
                  isOn: isOnFertilizer,
                  onSwitchChanged: (bool value) {
                    setState(() {
                      isOnFertilizer = value;
                    });
                  }),
              const Gap(20),
              SectionOfAction(
                  controllerSeconds: controllerSecondsPesticide,
                  controllerMinutes: controllerMinutesPesticide,
                  controllerHours: controllerHoursPesticide,
                  focusNodeSeconds: focusNodeSecondsPesticide,
                  focusNodeMinutes: focusNodeMinutesPesticide,
                  focusNodeHours: focusNodeHoursPesticide,
                  title: titlePesticide,
                  isOn: isOnPesticide,
                  onSwitchChanged: (bool value) {
                    setState(() {
                      isOnPesticide = value;
                    });
                  }),
              const Gap(20),
              const CustomButton(

                text: AppString.save,
                color: AppColor.colorButtonNew,
                colorOfButton: AppColor.blackColor,
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
