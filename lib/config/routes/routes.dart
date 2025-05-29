import 'package:final_proj/feature/auth/presentation/manager/auth_cubit.dart';
import 'package:final_proj/feature/auth/presentation/screens/forget_password/forget_password_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/splash/splash_screen.dart';
import 'package:final_proj/feature/detection/presentation/manager/detection_with_camera/detection_camera_cubit.dart';
import 'package:final_proj/feature/home_feature/presentation/manager/weather_cubit.dart';
import 'package:final_proj/feature/home_feature/presentation/screens/home.dart';

import 'package:final_proj/feature/home_layout/presentation/cubit/cubit/home_layout_cubit.dart';
import 'package:final_proj/feature/home_layout/presentation/screen/home_layout_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../feature/detection/data_source/model/detection_model.dart';
import '../../feature/detection/presentation/screen/detection_with_camera.dart';
import '../../feature/home_feature/presentation/screens/flutter_map_screen.dart';

class AppRoute {
  static const home = '/home';
  static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static const homeLayout = '/homeLayout';
  static const flutterMapScreen = '/flutterMapScreen';
  static const detectionWithCamera = '/DetectionWithCamera';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
          path: detectionWithCamera,
          builder: (context, state) {
            final detectionModel = state.extra as DetectionModel;
            return BlocProvider(
              create: (context) => DetectionCameraCubit(),
              child: DetectionWithCamera(detectionModel: detectionModel),
            );
          }),
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: signInScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: forgetPasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: homeLayout,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeLayoutCubit(),
          child: const HomeLayoutScreen(),
        ),
      ),
      GoRoute(
        path: flutterMapScreen,
        builder: (context, state) {
          final latLng = state.extra as LatLng;
          return BlocProvider(
            create: (context) => WeatherCubit(),
            child: FlutterMapScreen(latLng: latLng),
          );
        },
      ),
    ],
  );
}
