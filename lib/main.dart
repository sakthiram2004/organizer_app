import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';
import 'package:organizer_app/Provider/image_picker_provider.dart';
import 'package:organizer_app/Provider/page_index_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
      ChangeNotifierProvider(create: (_) => PageIndexProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      initialRoute: "/main_screen",
      getPages: PageRoutes.routes,
    );
  }
}
