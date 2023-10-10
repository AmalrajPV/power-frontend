// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:power_monitor/models/user_register_model.dart';
import 'package:power_monitor/pages/info_screen.dart';
import 'package:power_monitor/pages/waiting_screen.dart';
import 'package:power_monitor/services/auth_services.dart';
import 'package:power_monitor/utils/password_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _consumernoController = TextEditingController();
  final TextEditingController _productidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
              icon: const Icon(Icons.info_outline_rounded))
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign Up",
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
                    controller: _usernameController,
                    validator: ValidationBuilder()
                        .minLength(
                            3, 'Username must be at least 3 characters long')
                        .build(),
                    decoration: const InputDecoration(
                      hintText: "User Name",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF777777),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: ValidationBuilder()
                        .email('Invalid email address')
                        .build(),
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _consumernoController,
                    validator: ValidationBuilder()
                        .minLength(16,
                            'Consumer Number must be at least 16 characters long')
                        .maxLength(16,
                            'Consumer Number must be less than 16 characters long')
                        .build(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    decoration: const InputDecoration(
                      hintText: "Consumer Number",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _productidController,
                    validator: ValidationBuilder()
                        .minLength(
                            6, 'Product ID must be at least 6 characters long')
                        .build(),
                    decoration: const InputDecoration(
                      hintText: "Product Id",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword1,
                    validator: ValidationBuilder()
                        .minLength(
                            6, 'Password must be at least 6 characters long')
                        .build(),
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword1 = !_showPassword1;
                          });
                        },
                        child: Icon(
                          !_showPassword1 ? Icons.lock : Icons.lock_open,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: !_showPassword2,
                    validator: ValidationBuilder()
                        .minLength(
                            6, 'Password must be at least 6 characters long')
                        .password(_passwordController.text)
                        .build(),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF777777)),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword2 = !_showPassword2;
                          });
                        },
                        child: Icon(
                          !_showPassword2 ? Icons.lock : Icons.lock_open,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
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
                          User? user = await AuthService().register(
                              _usernameController.text,
                              _emailController.text,
                              _consumernoController.text,
                              _productidController.text,
                              _passwordController.text);
                          setState(() {
                            isLoading = false;
                          });
                          if (user != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WaitingScreen(
                                  user: user,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF44BAC2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: !isLoading
                            ? const Text(
                                "Sign Up",
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                              )
                            : const CircularProgressIndicator(
                                color: Color(0xffffffff),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text("Sign In"),
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
