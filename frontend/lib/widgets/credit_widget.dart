import 'package:flutter/material.dart';

class CreditWidget extends StatefulWidget {
  const CreditWidget({super.key});
  @override
  CreditWidgetState createState() => CreditWidgetState();
}

class CreditWidgetState extends State<CreditWidget> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Column(
        children: [
          Text('Credit'),
          Center(
            child: Container(
              color: Colors.red,
              child: Row(
                children: [
                  Text('S'),
                  SizedBox(width: 5),
                  Text('500'),
                ],
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
