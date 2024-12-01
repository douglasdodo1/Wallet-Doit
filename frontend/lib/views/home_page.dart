import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Text('Balance component'),
        backgroundColor: Color(0xFFA3A3A4),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 2,
              color: Colors.black,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              color: const Color.fromARGB(255, 9, 255, 0),
            ),
            Expanded(
              child: Container(
                height: 2 / 3,
                color: const Color.fromARGB(255, 0, 0, 255),
              ),
            ),
            Container(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
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
