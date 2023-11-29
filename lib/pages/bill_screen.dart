import 'package:flutter/material.dart';
import 'package:power_monitor/utils/bill_card.dart';

import 'previous_bill_list.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bill",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 56, 153, 160),
              ),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: 20),
            const BillCard(),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Pay Now'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Previous Bills",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color.fromARGB(255, 56, 153, 160),
              ),
              textScaleFactor: 1.5,
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: PreviousBillsList(),
            ),
          ],
        ),
      ),
    );
  }
}
