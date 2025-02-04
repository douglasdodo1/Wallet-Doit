import 'package:flutter/material.dart';

class PaymentListWidget extends StatefulWidget {
  const PaymentListWidget({super.key});

  @override
  PaymentListWidgetState createState() => PaymentListWidgetState();
}

class PaymentListWidgetState extends State<PaymentListWidget> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.8,
      child: Column(
        children: [
          Text('Payment list'),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
