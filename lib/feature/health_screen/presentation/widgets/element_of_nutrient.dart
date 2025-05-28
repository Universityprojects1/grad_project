import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/fonts.dart';

class ElementOfNutrient extends StatelessWidget {
  const ElementOfNutrient({
    super.key,
    required this.title,
    required this.result,
  });

  final String title;

  final String result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.colorButtonNew,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.textRegular16(context)
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const Gap(5),
                Text(
                  result,
                  style: AppFonts.textSemiBold20(context),
                ),
              ],
            ),
          ),
        ));
  }
}
