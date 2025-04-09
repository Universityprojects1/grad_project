import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/material.dart';

AppBar buildAppBarOfAuth(
    {required final String title,
    final void Function()? onPressed,
    required BuildContext context}) {
  return AppBar(
    leading: const SizedBox(),
    title: Text(
      title,
      style: AppFonts.textSemiBold20(context),
    ),
    centerTitle: true,
  );
}
