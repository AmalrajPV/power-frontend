import 'package:flutter/material.dart';
import 'package:power_monitor/constants.dart';
import 'package:power_monitor/models/user_register_model.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key, required this.user});
  final User user;
  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  int minutes = 5;
  int seconds = 0;
  Timer? timer;
  bool running = false;
  bool success = false;
  final socket = io.io(socketUrl, <String, dynamic>{
    'transports': ['websocket'],
  });
  @override
  void initState() {
    super.initState();
    establishWebSocketConnection();
    startTimer();
  }

  void startTimer() {
    setState(() {
      running = true;
    });
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (minutes == 0 && seconds == 0) {
        timer.cancel();
        onTimerFinished();
      } else {
        setState(() {
          if (seconds == 0) {
            minutes--;
            seconds = 59;
          } else {
            seconds--;
          }
        });
      }
    });
  }

  void establishWebSocketConnection() {
    socket.on('connect', (_) {
      socket.emit('join_verification', widget.user.id);
    });

    socket.on('verificationSuccess', (_) {
      timer?.cancel();
      setState(() {
        success = true;
      });
    });

    socket.on('disconnect', (_) {});
  }

  void onTimerFinished() {
    setState(() {
      running = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    socket.disconnect();
    super.dispose();
  }

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
                  image: AssetImage("assets/images/check-email.gif"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Verify E-mail",
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                !success
                    ? Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14),
                              children: <TextSpan>[
                                const TextSpan(
                                  text:
                                      'The verification has been send to the email ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: widget.user.email,
                                  style:
                                      const TextStyle(color: Color(0xfff24738)),
                                ),
                                const TextSpan(
                                  text: '. Verify it there with in ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text:
                                      '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                  style:
                                      const TextStyle(color: Color(0xff44bac2)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const Icon(
                            Icons.verified,
                            color: Color(0xff00bb00),
                            size: 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Success..!"),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text(
                              "Go to Login",
                              style: TextStyle(color: Color(0xff0000ff)),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
