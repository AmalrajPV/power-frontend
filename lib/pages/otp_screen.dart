import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
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
                  "Verify OTP",
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
                  "OTP has been send to email amal@gmail.com.",
                  style: TextStyle(height: 2, color: Color(0xff999999)),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                              hintText: "0",
                              hintStyle:
                                  const TextStyle(color: Color(0xffaaaaaa)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff44bac2)))),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                              hintText: "0",
                              hintStyle:
                                  const TextStyle(color: Color(0xffaaaaaa)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff44bac2)))),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                              hintText: "0",
                              hintStyle:
                                  const TextStyle(color: Color(0xffaaaaaa)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff44bac2)))),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                              hintText: "0",
                              hintStyle:
                                  const TextStyle(color: Color(0xffaaaaaa)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff44bac2)))),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF44BAC2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "VERIFY",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
