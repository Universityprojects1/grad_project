import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/auth/presentation/widgets/custom_app-bar_of-auth.dart';
import 'package:final_proj/feature/auth/presentation/widgets/textFormFieldOfAuth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/routes/routes.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/component/custom_button.dart';
import '../../../../../core/utils/component/logo.dart';
import '../../../../../core/utils/fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarOfAuth(title: AppString.signUp, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Gap(30),
            const Logo(),
            const Gap(15),
            CustomTextFieldOfAuth(
              title: AppString.name,
              controller: TextEditingController(),
              readOnly: false,
            ),
            CustomTextFieldOfAuth(
              title: AppString.email,
              controller: TextEditingController(),
              readOnly: false,
            ),
            CustomTextFieldOfAuth(
              title: AppString.phone,
              controller: TextEditingController(),
              readOnly: false,
            ),
            CustomTextFieldOfAuth(
              title: AppString.password,
              controller: TextEditingController(),
              readOnly: false,
            ),
            const Gap(15),
            const CustomButton(
                text: AppString.signUp, color: AppColor.primaryColor),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(AppString.doNotHaveAccount),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRoute.signInScreen);
                    },
                    child: Text(
                      AppString.signIn,
                      style: AppFonts.textSemiBold16(context)
                          .copyWith(color: AppColor.primaryColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
