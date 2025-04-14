import 'package:final_proj/config/routes/routes.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/auth/presentation/widgets/custom_app-bar_of-auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/component/custom_button.dart';
import '../../manager/auth_cubit.dart';
import '../../widgets/textFormFieldOfAuth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.res,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
          GoRouter.of(context).pushReplacement(AppRoute.signInScreen);
        } else if (state is AuthResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: buildAppBarOfAuth(
            title: AppString.forgotPasswordWithoutQuestionMark,
            context: context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                const Gap(30),
                CustomTextFieldOfAuth(
                  obscureText: false,
                  title: AppString.email,
                  controller: context.read<AuthCubit>().email,
                  readOnly: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                const Gap(15),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthResetPasswordLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                        onTap: () {
                          if (key.currentState!.validate()) {
                            context.read<AuthCubit>().resetPassword();
                          }
                        },
                        text: AppString.next,
                        color: AppColor.primaryColor);
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
