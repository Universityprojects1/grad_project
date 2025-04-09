import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/cache/storage_token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageToken storageToken = StorageToken();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(30),
        Text(
          "Montreal",
          style: AppFonts.textRegular16(context)
              .copyWith(fontSize: 40, color: AppColor.whiteColor),
        ),
        Text(
          "19*",
          style: AppFonts.textRegular16(context)
              .copyWith(fontSize: 70, color: AppColor.whiteColor),
        ),
        Text(
          "Clear",
          style: AppFonts.textRegular16(context).copyWith(
              fontSize: 30,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Temp",
              style: AppFonts.textRegular16(context).copyWith(
                  fontSize: 24,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "humidity",
              style: AppFonts.textRegular16(context).copyWith(
                  fontSize: 24,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
