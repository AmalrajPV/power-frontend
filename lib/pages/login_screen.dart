// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:power_monitor/pages/info_screen.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()));
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    textScaleFactor: 2,
                    style: TextStyle(
                      color: Color(0xFF44BAC2),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: AssetImage("assets/images/login-img.png"),
                    height: 200,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF777777),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidationBuilder()
                        .email("Enter a valid email address")
                        .required("Email is required")
                        .build(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordcontroller,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          !_showPassword ? Icons.lock : Icons.lock_open,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: ValidationBuilder()
                        .minLength(
                            6, "Password must be at least 6 characters long")
                        .required("Password is required")
                        .build(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && !isLoading) {
                          setState(() {
                            isLoading = true;
                          });
                          // login
                          if (await _auth.login(_emailcontroller.text,
                              _passwordcontroller.text)) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            print("Invalid credentials");
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF44BAC2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: !isLoading
                            ? const Text(
                                "Login",
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: const Text("Create Account"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
