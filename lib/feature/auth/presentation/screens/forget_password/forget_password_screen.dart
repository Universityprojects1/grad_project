import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/auth/presentation/widgets/custom_app-bar_of-auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/component/custom_button.dart';
import '../../widgets/textFormFieldOfAuth.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarOfAuth(
          title: AppString.forgotPasswordWithoutQuestionMark, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Gap(30),
            CustomTextFieldOfAuth(
              title: AppString.email,
              controller: TextEditingController(),
              readOnly: false,
            ),
            const Gap(15),
            const CustomButton(
                text: AppString.next, color: AppColor.primaryColor),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
