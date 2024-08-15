import 'package:get/get_connect/connect.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:organizer_app/screens/create_event.dart';
import 'package:organizer_app/screens/dashboard_screen.dart';
import 'package:organizer_app/screens/dummy.dart';
import 'package:organizer_app/screens/event_list.dart';
import 'package:organizer_app/screens/login_screen.dart';
import 'package:organizer_app/screens/signup_screen.dart';
import 'package:organizer_app/screens/sub_event_screen.dart';

class PageRoutes extends GetConnect {
  static const String loginscreen = "/loginScreen";
  static const String signupscreen = "/signupScreen";
  static const String dummy = "/dummy";
  static const String createEvent = "/createEvent";
    static const String subEvent = "/subEvent";
    static const String dashboard = "/dashboard";
     static const String eventlist = "/eventlist";
  static List<GetPage> routes = [
    GetPage(name: loginscreen, page: () => const LoginScreen()),
    GetPage(name: signupscreen, page: () => const SignupScreen()),
    GetPage(name: dummy, page: () => const Dummy()),
    GetPage(name: createEvent, page: ()=> const CreateEvent()),
    GetPage(name: subEvent, page: () => const SubEventScreen()),
    
    GetPage(name: dashboard, page: () => const Dashboard()),
    GetPage(name: eventlist, page: () => const EventList()),
  ];
}
