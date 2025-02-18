import 'package:flutter/material.dart';
import 'package:frontend/widgets/homeWidgets/payment_list_widget.dart';
import 'package:frontend/widgets/menuWidgets/creditWidgets/credit_widget.dart';
import 'package:frontend/widgets/homeWidgets/debit_widget.dart';
import 'package:frontend/widgets/homeWidgets/month_payment.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          toolbarHeight: 150,
          title: DebitWidget(debit: 1000.00)),
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Container(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: Container(
                  color: Color.fromARGB(255, 250, 250, 250),
                  child: CreditWidget(creditUsed: 200, credit: 500)),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  color: Color.fromARGB(255, 250, 250, 250),
                  child: MouthPayment()),
            ),
            Container(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              flex: 4,
              child: Container(
                  color: Color.fromARGB(255, 250, 250, 250),
                  child: PaymentListWidget()),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(height: 80, color: Colors.yellow),
    );
  }
}
