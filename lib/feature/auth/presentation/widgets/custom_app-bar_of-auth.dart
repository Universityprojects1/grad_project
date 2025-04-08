import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBarOfAuth(
    {required final String title,
    final void Function()? onPressed,
    required BuildContext context}) {
  return AppBar(
    leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        )),
    title: Text(
      title,
      style: AppFonts.textSemiBold20(context),
    ),
    centerTitle: true,
  );
}
