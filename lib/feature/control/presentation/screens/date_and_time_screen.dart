import 'package:cart_stepper/cart_stepper.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/bottom_date_picker.dart';
import '../../../../core/utils/component/custom_timer.dart';
import '../../../../core/utils/fonts.dart';
import '../../../auth/presentation/widgets/textFormFieldOfAuth.dart';

class DateAndTimeScreen extends StatefulWidget {
  const DateAndTimeScreen(
      {super.key, required this.title, required this.customTimer});

  final String title;
  final CustomTimer customTimer;

  @override
  State<DateAndTimeScreen> createState() => _DateAndTimeScreenState();
}

class _DateAndTimeScreenState extends State<DateAndTimeScreen> {
  final FocusNode startTimeFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.customTimer.onUpdate = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void dispose() {
    startTimeFocusNode.dispose();
    dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.dateAndTime,
          style: AppFonts.textBold20(context).copyWith(color: Colors.white),
        ),
        leading: const SizedBox(),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.assetsBackgroundHome),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Text(
                  "${AppString.txtOfDateAndTime} ${widget.title}",
                  style: AppFonts.textSemiBold20(context)
                      .copyWith(color: AppColor.blackColor),
                ),
                const Gap(15),
                CustomTextFieldOfAuth(
                  filled: true,
                  obscureText: false,
                  title: AppString.date,
                  focusNode: dateFocusNode,
                  controller: widget.customTimer.dateController,
                  onTap: () {
                    sheetBottomOfDate(
                      title: AppString.dateAndTime,
                      context: context,
                      onSubmit: (date) {
                        setState(() {
                          widget.customTimer.dateController.text =
                              DateFormat('dd-MM-yyyy').format(date);
                        });
                      },
                    ).show(context);
                    dateFocusNode.unfocus();
                  },
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                CustomTextFieldOfAuth(
                  filled: true,
                  focusNode: startTimeFocusNode,
                  obscureText: false,
                  title: AppString.startTime,
                  controller: widget.customTimer.startTimeController,
                  onTap: () {
                    sheetBottomOfTime(
                      title: AppString.startTime,
                      context: context,
                      onSubmit: (date) {
                        setState(() {
                          widget.customTimer.startTimeController.text =
                              DateFormat('hh:mm a').format(date);
                        });
                      },
                    ).show(context);
                    startTimeFocusNode.unfocus();
                  },
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                Center(
                    child: Column(
                  children: [
                    Text(
                      AppString.startTime,
                      style: AppFonts.textSemiBold16(context)
                          .copyWith(color: AppColor.whiteColor),
                    ),
                    _buildStepper(),
                  ],
                )),
                const Gap(20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red),
                    child: Text(
                      widget.customTimer
                          .formatDuration(widget.customTimer.count),
                      style: AppFonts.textBold20(context)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const Gap(30),
                CustomButton(
                  text: AppString.save,
                  color: AppColor.primaryColor,
                  onTap: () {
                    widget.customTimer.calculateTimeDifference();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return CartStepperInt(
      value: widget.customTimer.counter,
      size: 40,
      alwaysExpanded: true,
      style: CartStepperTheme.of(context).copyWith(
          activeForegroundColor: Colors.black,
          elevation: 0,
          activeBackgroundColor: Colors.transparent),
      didChangeCount: (count) {
        setState(() {
          widget.customTimer.counter = count;
        });
      },
    );
  }
}
