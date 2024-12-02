import 'package:flutter/material.dart';

import '../app_style.dart';
import '../helper.dart';

class CustomCampaignTextFiled extends StatelessWidget {
  const CustomCampaignTextFiled(
      {super.key,
      this.icon,
      required this.hint,
      required this.maxLine,
      required this.labelText,
      this.textEditingController,
      this.textInputType,
      this.validator});

  final String hint;
  final String labelText;
  final Icon? icon;
  final int maxLine;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
          border: Helper.buildOutlineInputBorder(),
          enabledBorder: Helper.buildOutlineInputBorder(),
          disabledBorder: Helper.buildOutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(),
          hintText: hint,
          hintStyle: TextStyle(),
          prefixIcon: icon),
      maxLines: maxLine,
    );
  }
}
