import 'package:chat_app/presetations/guestAccountPage/guestAccount_page.dart';
import 'package:chat_app/presetations/homePage/home_page.dart';
import 'package:chat_app/presetations/logInPage/login_page.dart';
import 'package:chat_app/presetations/signUpPage/signup_page.dart';
import 'package:chat_app/presetations/splashPage/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String splash = '/';
  String logIn = 'login';
  String guest = 'guest';
  String signUp = 'signup';
  String home = 'home';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const SplashPage(),
    'guest': (context) => const GuestLogInPage(),
    'login': (context) => LogInPage(),
    'signup': (context) => const SignUpPage(),
    'home': (context) => const HomePage(),
  };
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
}
