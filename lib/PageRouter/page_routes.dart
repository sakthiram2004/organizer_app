import 'package:get/get_connect/connect.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:organizer_app/screens/dummy.dart';
import 'package:organizer_app/screens/login_screen.dart';
import 'package:organizer_app/screens/signup_screen.dart';

class PageRoutes extends GetConnect {
  static const String loginscreen = "/loginScreen";
  static const String signupscreen = "/signupScreen";
  static const String dummy = "/dummy";

  static List<GetPage> routes = [
    GetPage(name: loginscreen, page: () => const LoginScreen()),
    GetPage(name: signupscreen, page: () => const SignupScreen()),
    GetPage(name: dummy, page: () => const Dummy())
  ];
}
