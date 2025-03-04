import 'package:flutter/material.dart';

class CardPaymentWidget extends StatefulWidget {
  final String paymentName;
  int iconCode;

  CardPaymentWidget({
    super.key,
    required this.paymentName,
    required this.iconCode,
  });

  @override
  CardPaymentWidgetState createState() => CardPaymentWidgetState();
}

class CardPaymentWidgetState extends State<CardPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconData(widget.iconCode, fontFamily: 'MaterialIcons'),
              size: 40, // Defina o tamanho do ícone
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: Colors.black,
              ))),
            ),
            Text(
              widget.paymentName,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
