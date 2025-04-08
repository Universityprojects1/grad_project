import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/auth/presentation/manager/auth_cubit.dart';
import 'package:final_proj/feature/auth/presentation/widgets/custom_app-bar_of-auth.dart';
import 'package:final_proj/feature/auth/presentation/widgets/textFormFieldOfAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/routes/routes.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/component/custom_button.dart';
import '../../../../../core/utils/component/logo.dart';
import '../../../../../core/utils/fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.res,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        } else if (state is AuthSignUpFailure) {
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
        appBar: buildAppBarOfAuth(title: AppString.signUp, context: context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(30),
                  const Logo(),
                  const Gap(15),
                  CustomTextFieldOfAuth(
                    obscureText: false,
                    title: AppString.name,
                    controller: context.read<AuthCubit>().name,
                    readOnly: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
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
                  CustomTextFieldOfAuth(
                    obscureText: false,
                    title: AppString.phone,
                    controller: context.read<AuthCubit>().phone,
                    readOnly: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is required';
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldOfAuth(
                    obscureText: true,
                    title: AppString.password,
                    controller: context.read<AuthCubit>().password,
                    readOnly: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSignUpLoading) {
                        return const CircularProgressIndicator();
                      }
                      return CustomButton(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              context.read<AuthCubit>().signUp();
                            }
                          },
                          text: AppString.signUp,
                          color: AppColor.primaryColor);
                    },
                  ),
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
          ),
        ),
      ),
    );
  }
}
