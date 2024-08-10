import 'package:get/get_connect/connect.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:organizer_app/screens/login_screen.dart';
import 'package:organizer_app/screens/signup_screen.dart';

class PageRoutes extends GetConnect {
  static const String loginscreen = "/loginScreen";
  static const String signupscreen = "/signupScreen";

  static List<GetPage> routes = [
    GetPage(name: loginscreen, page: ()=>LoginScreen()),
    GetPage(name: signupscreen, page: ()=>SignupScreen())
    
  ];
}
