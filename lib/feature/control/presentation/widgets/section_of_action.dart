import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/fonts.dart';

class SectionOfAction extends StatefulWidget {
  const SectionOfAction({
    super.key,
    required this.controllerSeconds,
    required this.controllerMinutes,
    required this.controllerHours,
    required this.focusNodeSeconds,
    required this.focusNodeMinutes,
    required this.focusNodeHours,
    required this.title,
    required this.isOn,
    required this.onSwitchChanged,
  });

  final TextEditingController controllerSeconds;

  final TextEditingController controllerMinutes;

  final TextEditingController controllerHours;

  final FocusNode focusNodeSeconds;

  final FocusNode focusNodeMinutes;

  final FocusNode focusNodeHours;

  final String title;

  final bool isOn;

  final Function(bool) onSwitchChanged;

  @override
  State<SectionOfAction> createState() => _SectionOfActionState();
}

class _SectionOfActionState extends State<SectionOfAction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: AppFonts.textRegular16(context).copyWith(
                fontSize: 22,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold)),
        const Gap(5),
        Row(
          children: [
            Text("On/Off",
                style: AppFonts.textRegular16(context).copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            Switch.adaptive(
                activeColor: AppColor.primaryColor,
                value: widget.isOn,
                onChanged: widget.onSwitchChanged),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: AppColor.borderColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration.collapsed(hintText: "Seconds"),
                      keyboardType: TextInputType.number,
                      controller: widget.controllerSeconds,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      focusNode: widget.focusNodeSeconds,
                      style: AppFonts.textRegular16(context).copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            const Gap(5),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: AppColor.borderColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration.collapsed(hintText: "Minutes"),
                      keyboardType: TextInputType.number,
                      controller: widget.controllerMinutes,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      focusNode: widget.focusNodeMinutes,
                      style: AppFonts.textRegular16(context).copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            const Gap(5),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: AppColor.borderColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration.collapsed(hintText: "Hours"),
                      keyboardType: TextInputType.number,
                      controller: widget.controllerHours,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      focusNode: widget.focusNodeHours,
                      style: AppFonts.textRegular16(context).copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
