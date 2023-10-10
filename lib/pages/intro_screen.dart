// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Image(
                image: AssetImage("assets/images/intro-img.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome to Power Monitor !",
                textScaleFactor: 2,
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Take control of your energy consumption with our powerful monitoring app. With real-time insights and convenient features, managing your power usage has never been easier.",
                style: TextStyle(height: 2, color: Color(0xff999999)),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isFirstTime', false);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0Xff44bac2)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue  ",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xffffffff),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
