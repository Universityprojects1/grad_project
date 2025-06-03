import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/feature/control/presentation/cubit/pump_control_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PumpControlCubit, PumpControlState>(
      listener: (context, state) {
        // Show error message if there is any
        if (state.errorMessage != null) {
          _showErrorSnackBar(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          isOn: context.read<PumpControlCubit>().isIrrigationOn,
                          onSwitchChanged: (bool value) {
                            final cubit = context.read<PumpControlCubit>();
                            context.read<PumpControlCubit>().isIrrigationOn = value;
                            cubit.controlIrrigationPump(
                              isOn: value,
                              hours: int.tryParse(controllerHoursIrrigation.text) ?? 0,
                              minutes: int.tryParse(controllerMinutesIrrigation.text) ?? 0,
                              seconds: int.tryParse(controllerSecondsIrrigation.text) ?? 0,
                            );
                          },
                        ),
                        const Gap(20),
                        SectionOfAction(
                          controllerSeconds: controllerSecondsFertilizer,
                          controllerMinutes: controllerMinutesFertilizer,
                          controllerHours: controllerHoursFertilizer,
                          focusNodeSeconds: focusNodeSecondsFertilizer,
                          focusNodeMinutes: focusNodeMinutesFertilizer,
                          focusNodeHours: focusNodeHoursFertilizer,
                          title: titleFertilizer,
                          isOn: context.read<PumpControlCubit>().isFertilizerOn,
                          onSwitchChanged: (bool value) {
                            final cubit = context.read<PumpControlCubit>();
                            context.read<PumpControlCubit>().isFertilizerOn = value;
                            cubit.controlFertilizerPump(
                              isOn: value,
                              hours: int.tryParse(controllerHoursFertilizer.text) ?? 0,
                              minutes: int.tryParse(controllerMinutesFertilizer.text) ?? 0,
                              seconds: int.tryParse(controllerSecondsFertilizer.text) ?? 0,
                            );
                          },
                        ),
                        const Gap(20),
                        SectionOfAction(
                          controllerSeconds: controllerSecondsPesticide,
                          controllerMinutes: controllerMinutesPesticide,
                          controllerHours: controllerHoursPesticide,
                          focusNodeSeconds: focusNodeSecondsPesticide,
                          focusNodeMinutes: focusNodeMinutesPesticide,
                          focusNodeHours: focusNodeHoursPesticide,
                          title: titlePesticide,
                          isOn: context.read<PumpControlCubit>().isPesticideOn,
                          onSwitchChanged: (bool value) {
                            final cubit = context.read<PumpControlCubit>();
                            context.read<PumpControlCubit>().isPesticideOn = value;
                            cubit.controlPesticidePump(
                              isOn: value,
                              hours: int.tryParse(controllerHoursPesticide.text) ?? 0,
                              minutes: int.tryParse(controllerMinutesPesticide.text) ?? 0,
                              seconds: int.tryParse(controllerSecondsPesticide.text) ?? 0,
                            );
                          },
                        ),
                        const Gap(20),
                        CustomButton(
                          text: AppString.save,
                          color: AppColor.colorButtonNew,
                          colorOfButton: AppColor.blackColor,
                          onTap: () {
                            final cubit = context.read<PumpControlCubit>();
                            cubit.saveAllPumpSettings(
                              isIrrigationOn: state.isIrrigationOn,
                              irrigationHours: int.tryParse(controllerHoursIrrigation.text) ?? 0,
                              irrigationMinutes: int.tryParse(controllerMinutesIrrigation.text) ?? 0,
                              irrigationSeconds: int.tryParse(controllerSecondsIrrigation.text) ?? 0,
                              
                              isFertilizerOn: state.isFertilizerOn,
                              fertilizerHours: int.tryParse(controllerHoursFertilizer.text) ?? 0,
                              fertilizerMinutes: int.tryParse(controllerMinutesFertilizer.text) ?? 0,
                              fertilizerSeconds: int.tryParse(controllerSecondsFertilizer.text) ?? 0,
                              
                              isPesticideOn: state.isPesticideOn,
                              pesticideHours: int.tryParse(controllerHoursPesticide.text) ?? 0,
                              pesticideMinutes: int.tryParse(controllerMinutesPesticide.text) ?? 0,
                              pesticideSeconds: int.tryParse(controllerSecondsPesticide.text) ?? 0,
                            );
                            _showSuccessSnackBar(context, 'Saving pump settings...');
                          },
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    controllerSecondsIrrigation.dispose();
    controllerMinutesIrrigation.dispose();
    controllerHoursIrrigation.dispose();
    controllerSecondsFertilizer.dispose();
    controllerMinutesFertilizer.dispose();
    controllerHoursFertilizer.dispose();
    controllerSecondsPesticide.dispose();
    controllerMinutesPesticide.dispose();
    controllerHoursPesticide.dispose();
    
    focusNodeSecondsIrrigation.dispose();
    focusNodeMinutesIrrigation.dispose();
    focusNodeHoursIrrigation.dispose();
    focusNodeSecondsFertilizer.dispose();
    focusNodeMinutesFertilizer.dispose();
    focusNodeHoursFertilizer.dispose();
    focusNodeSecondsPesticide.dispose();
    focusNodeMinutesPesticide.dispose();
    focusNodeHoursPesticide.dispose();
    
    super.dispose();
  }
}
