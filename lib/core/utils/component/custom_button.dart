import 'package:flutter/material.dart';

import '../app_color.dart';
import '../fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    this.onTap,
    this.width = double.infinity,
    this.colorOfButton = AppColor.whiteColor,
    this.boarderOfButton = false,
    this.height = 50,
  });

  final String text;

  final Color color;

  final void Function()? onTap;

  final double width;
  final double height;

  final bool boarderOfButton;

  final Color colorOfButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: boarderOfButton
                ? Border.all(color: AppColor.primaryColor)
                : null,
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Center(
            child: Text(
          text,
          style:
              AppFonts.textSemiBold16(context).copyWith(color: colorOfButton),
        )),
      ),
    );
  }
}
