import 'package:final_proj/feature/auth/presentation/screens/forget_password/forget_password_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/splash/splash_screen.dart';
import 'package:final_proj/feature/home_feature/home.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static const home = '/home';
  static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),     GoRoute(
        path: forgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
