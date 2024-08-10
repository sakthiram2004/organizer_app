import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: LoginScreen(),
      initialRoute: "/loginScreen",
      getPages: PageRoutes.routes,
    );
  }
}
