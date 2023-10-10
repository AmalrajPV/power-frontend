import 'package:flutter/material.dart';
import 'package:power_monitor/utils/bill_card.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Bill"),
          // backgroundColor: const Color(0xFF44BAC2),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bill",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromARGB(255, 56, 153, 160)),
                textScaleFactor: 1.5),
            const SizedBox(
              height: 20,
            ),
            const BillCard(),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white
                ),
                onPressed: () {},
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
