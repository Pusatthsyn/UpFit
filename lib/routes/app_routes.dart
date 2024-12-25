import 'package:get/get.dart';
import 'package:upfit/features/dashboard/dashboard.dart';
import 'package:upfit/features/dashboard/dashboard_binding.dart';
import 'package:upfit/features/home/home_binding.dart';
import 'package:upfit/features/home/home_screen.dart';
import 'package:upfit/features/login/login_binding.dart';
import 'package:upfit/features/login/login_screen.dart';
import 'package:upfit/features/signUp/signUp_binding.dart';
import 'package:upfit/features/signUp/signUp_screen.dart';
import 'package:upfit/features/splash/splash_binding.dart';
import 'package:upfit/features/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
}

class AppScreens {
  static final screens = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding(),
        middlewares: []),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => Dashboard(),
      binding: DashboardBinding(),
    ),
  ];
}
