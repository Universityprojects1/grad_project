import 'package:flutter/material.dart';



import 'app_color.dart';
import 'app_style.dart';

abstract class AppFonts {
  static TextStyle textRegular16(context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textBold16(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }
  static TextStyle textBold17(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 17),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textMedium16(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
    );
  }
  static TextStyle textMedium18(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 18),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
    );
  }


  static TextStyle textMedium20(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 20),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textSemiBold16(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 16),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textSemiBold20(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 20),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
    );

  }
  static TextStyle textBold20(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 20),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
    );

  }

  static TextStyle textRegular12(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 12),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textSemiBold24(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 24),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textRegular14(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 14),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle textRegular25(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 25),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textSemiBold18(BuildContext context) {
    return TextStyle(
      color: AppColor.blackColor,
      fontSize: AppStyle.responsiveFont(context: context, fontSize: 18),
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
    );
  }
}
