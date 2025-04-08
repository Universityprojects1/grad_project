import 'package:final_proj/config/routes/routes.dart';
import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/custom_button.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:final_proj/feature/auth/presentation/manager/auth_cubit.dart';
import 'package:final_proj/feature/auth/presentation/widgets/textFormFieldOfAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/component/logo.dart';
import '../../widgets/custom_app-bar_of-auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarOfAuth(context: context, title: AppString.signIn),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.res,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            );
          } else if (state is AuthSignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(30),
                  const Logo(),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .push(AppRoute.forgetPasswordScreen);
                        },
                        child: const Text(AppString.forgotPassword)),
                  ),
                  const Gap(15),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSignInLoading) {
                        return const CircularProgressIndicator();
                      }
                      return CustomButton(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              context.read<AuthCubit>().signIn();
                            }
                          },
                          text: AppString.signIn,
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
                            GoRouter.of(context).push(AppRoute.signUpScreen);
                          },
                          child: Text(
                            AppString.signUp,
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
