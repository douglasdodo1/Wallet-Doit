import 'package:flutter/material.dart';

import 'paymentWidgets/modal_widget.dart';

class PaymentListWidget extends StatefulWidget {
  const PaymentListWidget({super.key});

  @override
  PaymentListWidgetState createState() => PaymentListWidgetState();
}

class PaymentListWidgetState extends State<PaymentListWidget> {
  final List<String> payments = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
  ];
  String? _draggingItem;

  void _showPaymentDialog(String name, double value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalWidget(paymentName: name, paymentValue: value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.8,
      child: Column(
        children: [
          const Text('Payment list',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.3,
                ),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: payments[index],
                    onDragStarted: () {
                      setState(() {
                        _draggingItem = payments[index];
                      });
                    },
                    onDraggableCanceled: (velocity, Offset) {
                      setState(() {
                        _draggingItem = null;
                      });
                    },
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    feedback: Material(
                      
                    ),
                    child: GestureDetector(
                      onTap: () => _showPaymentDialog(payments[index], 50.00),
                      onLongPress: () {},
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
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
                          ),
                          Center(
                            child: Text(
                              payments[index],
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
