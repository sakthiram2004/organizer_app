import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizer_app/Helper/api_service.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';
import 'package:organizer_app/Provider/auth_provider.dart';
import 'package:organizer_app/Provider/image_picker_provider.dart';
import 'package:organizer_app/Provider/page_index_provider.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Widget/text_style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (_) => PageIndexProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await resetToken();
    String? token = prefs.getString("accessToken");
    print("your token is ++++++++++ $token");
    bool isValidToken = (token != null);
    return isValidToken;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                  child: Text(
                'Something went wrong.... ${snapshot.error}',
                style: textStyle(25, primaryColor, FontWeight.bold),
              )),
            ),
          );
        } else if (snapshot.hasData) {
          return GetMaterialApp(
            theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data! ? "/main_screen" : "/loginScreen",
            getPages: PageRoutes.routes,
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                  child: Text(
                'Something went wrong....',
                style: textStyle(25, primaryColor, FontWeight.bold),
              )),
            ),
          );
        }
      },
    );
  }
}

bool isTokenInvalid(String? message) {
  if (message == null) return false;
  const invalidMessages = [
    "token expired,login again",
    "token not found",
    "Invalid Token"
  ];
  return invalidMessages.contains(message);
}

Future<void> resetToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');

  try {
    final response = await http.get(
        Uri.parse("${Config.baseUrl}$getUserDetail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
    final Map<String, dynamic> jsonBodyData = jsonDecode(response.body);
    final message = jsonBodyData["message"]?.toString().toLowerCase().trim();

    if (isTokenInvalid(message)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("accessToken");
    }
  } catch (error) {
    print(error);
  }
}
