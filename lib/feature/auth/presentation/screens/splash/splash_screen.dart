import 'package:final_proj/config/routes/routes.dart';
import 'package:final_proj/core/cache/storage_token.dart';
import 'package:final_proj/core/utils/app_images.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/core/utils/component/logo.dart';
import 'package:final_proj/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageToken storageToken = StorageToken();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        String? token = await storageToken.getToken();
        if (token == null || token == "") {
          GoRouter.of(context).pushReplacement(AppRoute.signInScreen);
        } else {
          GoRouter.of(context).pushReplacement(AppRoute.homeLayout);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.assetsBackground),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const Gap(90),
              const Logo(),
              const Gap(30),
              Text(
                AppString.phyto,
                style: AppFonts.textBold20(context).copyWith(fontSize: 30),
              ),
              const Gap(30),
              Text(
                textAlign: TextAlign.center,
                AppString.txtOfSplash,
                style: AppFonts.textSemiBold20(context).copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
