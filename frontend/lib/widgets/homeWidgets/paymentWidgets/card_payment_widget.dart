import 'package:flutter/material.dart';

class CardPaymentWidget extends StatefulWidget {
  final String paymentName;

  const CardPaymentWidget({
    super.key,
    required this.paymentName,
  });

  @override
  CardPaymentWidgetState createState() => CardPaymentWidgetState();
}

class CardPaymentWidgetState extends State<CardPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.paymentName,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
