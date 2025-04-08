import 'package:final_proj/feature/auth/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:final_proj/feature/auth/presentation/screens/splash/splash_screen.dart';
import 'package:final_proj/feature/home_feature/home.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static const home = '/home';
  static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
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
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
