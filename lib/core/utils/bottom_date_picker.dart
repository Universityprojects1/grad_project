import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'fonts.dart';

BottomPicker sheetBottomOfDate(
    {required String title,
    required BuildContext context,
    dynamic Function(dynamic)? onSubmit}) {
  return BottomPicker.date(
    height: MediaQuery.sizeOf(context).height * .4,
    pickerTitle: Text(
      title,
      style: AppFonts.textSemiBold16(context),
    ),
    onSubmit: onSubmit,
    onCloseButtonPressed: () {
      print('Picker closed');
    },
    minDateTime: DateTime.now().subtract(const Duration(days: 365)),
    maxDateTime: DateTime.now().add(const Duration(days: 365)),
    initialDateTime: DateTime.now(),
    pickerTextStyle: AppFonts.textRegular14(context),
    buttonSingleColor: AppColor.primaryColor,
  );
}

BottomPicker sheetBottomOfTime(
    {required String title,
    required BuildContext context,
    dynamic Function(dynamic)? onSubmit}) {
  return BottomPicker.time(
    height: MediaQuery.sizeOf(context).height * .4,
    pickerTitle: Text(
      title,
      style: AppFonts.textSemiBold16(context),
    ),
    onSubmit: onSubmit,
    onCloseButtonPressed: () {
      print('Picker closed');
    },
    pickerTextStyle: AppFonts.textRegular14(context),
    buttonSingleColor: AppColor.primaryColor,
    initialTime: Time(),
  );
}
