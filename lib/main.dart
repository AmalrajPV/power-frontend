import 'package:flutter/material.dart';
import 'package:power_monitor/pages/home_screen.dart';
import 'package:power_monitor/pages/intro_screen.dart';
import 'package:power_monitor/routes/routes.dart';
import 'package:power_monitor/services/auth_services.dart';
import 'package:power_monitor/services/user_provider.dart';
import './pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  bool loggedin = await AuthService().isLoggedIn();
  runApp(ChangeNotifierProvider(
      create: (_) => UserProfileProvider(),
      child: MyApp(
        isFirstTime: isFirstTime,
        loggedin: loggedin,
      )));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool loggedin;
  const MyApp({super.key, required this.isFirstTime, required this.loggedin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power Monitor',
      routes: MyRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0Xff44bac2)),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: loggedin
          ? const HomeScreen()
          : (isFirstTime ? const IntroScreen() : const LoginScreen()),
    );
  }
}
