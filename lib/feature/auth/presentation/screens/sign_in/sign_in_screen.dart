import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:final_proj/feature/auth/presentation/widgets/textFormFieldOfAuth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/custom_app-bar_of-auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarOfAuth(context: context, title: AppString.signIn),
      body: GestureDetector(
        onTap: () {
          emailFocus.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Gap(30),
              CustomTextFieldOfAuth(
                title: AppString.email,
                controller: TextEditingController(),
                readOnly: false,
              ),
              CustomTextFieldOfAuth(
                title: AppString.password,
                controller: TextEditingController(),
                readOnly: false,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(AppString.forgotPassword)),
              const Gap(15),
              const CustomButton(
                  text: AppString.signIn, color: AppColor.primaryColor),
              const Gap(10),
              Text(
                AppString.txtOfPolicy,
                style: AppFonts.textRegular14(context)
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
