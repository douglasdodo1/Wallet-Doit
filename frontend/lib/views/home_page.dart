import 'package:flutter/material.dart';
import 'package:frontend/widgets/credit_widget.dart';
import 'package:frontend/widgets/debit_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150, // Defina a altura do AppBar
        title: DebitWidget(),
      ),
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
                color: const Color.fromARGB(255, 9, 255, 0),
                child: CreditWidget(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 255),
              ),
            ),
            Container(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: const Color.fromARGB(255, 255, 0, 0),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.yellow,
      ),
    );
  }
}
