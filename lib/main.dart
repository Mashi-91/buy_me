import 'dart:convert';
import 'dart:developer';

import 'package:buy_me/services/auth_service/auth_service.dart';
import 'package:buy_me/services/storage_services.dart';
import 'package:buy_me/const/utils/color.dart';
import 'package:buy_me/routes/app_pages.dart';
import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_binding.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_controller.dart';
import 'package:buy_me/ui/home/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  final prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buy Me',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.openSans().fontFamily,
        scaffoldBackgroundColor: AppColors.cardColor,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.cardColor),
        useMaterial3: true,
      ),
      initialRoute: initScreen == 0 || initScreen == null
          ? Routes.splashScreen
          : Routes.authScreen,
      initialBinding: SignInBinding(),
      getPages: AppPages.pages,
    );
  }
}
