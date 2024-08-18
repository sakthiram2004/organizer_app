import 'package:get/get_connect/connect.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:organizer_app/Widget/event_details.dart';
import 'package:organizer_app/Widget/video_player.dart';
import 'package:organizer_app/screens/CreateEvent/create_event.dart';
import 'package:organizer_app/screens/bottom_nav.dart';
import 'package:organizer_app/Auth/login_screen.dart';
import 'package:organizer_app/screens/main_screen.dart';
import 'package:organizer_app/Auth/signup_screen.dart';
import 'package:video_player/video_player.dart';

class PageRoutes extends GetConnect {
  static const String loginscreen = "/loginScreen";
  static const String signupscreen = "/signupScreen";
  static const String dummy = "/dummy";
  static const String createEvent = "/createEvent";
  static const String subEvent = "/subEvent";
  static const String bottomNav = "/bottom_navigation";
  static const String mainScreen = "/main_screen";
  static const String dashboard = "/dashboard";
  static const String eventlist = "/eventlist";
  static const String eventDetail = "/event_details";
  static const String videoPlayer = "/video_player";

  static List<GetPage> routes = [
    GetPage(name: loginscreen, page: () => const LoginScreen()),
    GetPage(name: signupscreen, page: () => const SignupScreen()),
    GetPage(name: createEvent, page: () => const CreateEvent()),
    GetPage(name: mainScreen, page: () => const MainScreen()),
    GetPage(name: bottomNav, page: () => const BottomNav()),
    GetPage(name: eventDetail, page: () => const EventDetailsScreen()),
  ];
}
