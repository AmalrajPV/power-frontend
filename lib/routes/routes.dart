import 'package:flutter/material.dart';
import 'package:power_monitor/pages/bill_screen.dart';
import 'package:power_monitor/pages/change_password_screen.dart';
import 'package:power_monitor/pages/home_screen.dart';
import 'package:power_monitor/pages/login_screen.dart';
import 'package:power_monitor/pages/profile_screen.dart';
import 'package:power_monitor/pages/register_screen.dart';

class MyRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => const HomeScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/change-password': (context) => const ChangePassword(),
    '/bills': (context) => const BillScreen(),
  };
}
