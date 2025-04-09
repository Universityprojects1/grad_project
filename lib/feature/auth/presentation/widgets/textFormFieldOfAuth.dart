import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/fonts.dart';

class CustomTextFieldOfAuth extends StatelessWidget {
  const CustomTextFieldOfAuth({
    super.key,
    FocusNode? focusNode,
    required this.title,
    required this.controller,
    required this.readOnly,
    this.validator,
    this.onTap,
    this.appearColor = false,
    this.isPadding = true,
    this.suffixIcon,
    this.prefixIcon,
    required this.obscureText,
    this.filled = false,
  }) : _focusNode = focusNode;

  final FocusNode? _focusNode;
  final String title;
  final TextEditingController controller;
  final bool readOnly;
  final bool appearColor;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool isPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isPadding ? 12.0 : 0),
      child: TextFormField(
        obscureText: obscureText,
        onTap: onTap,
        controller: controller,
        focusNode: _focusNode,
        style: AppFonts.textRegular16(context).copyWith(
            fontSize: 16,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500),
        cursorColor: AppColor.primaryColor,
        validator: validator,
        readOnly: readOnly,
        decoration: InputDecoration(
            fillColor: AppColor.borderColor,
            filled: filled,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon,
            label: Text(title),
            enabled: true,
            labelStyle: AppFonts.textSemiBold16(context)
                .copyWith(color: AppColor.blackColor),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.blackColor, width: 2),
                borderRadius: BorderRadius.circular(8)),
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.blackColor, width: 20),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.blackColor, width: 2),
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
