import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';
import 'package:organizer_app/Provider/image_picker_provider.dart';
import 'package:organizer_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImagePickerProvider>(
      create: (_) => ImagePickerProvider(),
      child: GetMaterialApp(
        // home: LoginScreen(),
        initialRoute: "/createEvent",
        getPages: PageRoutes.routes,
      ),
    );
  }
}
