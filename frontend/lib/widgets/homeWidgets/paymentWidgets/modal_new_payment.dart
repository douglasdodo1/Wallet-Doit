import 'package:flutter/material.dart';

class ModalNewPayment extends StatefulWidget {
  ModalNewPayment({super.key});

  @override
  ModalNewPaymentState createState() => ModalNewPaymentState();
}

class ModalNewPaymentState extends State<ModalNewPayment> {
  late TextEditingController titleController;
  late TextEditingController valueController;
  IconData selectedIcon = Icons.add_circle_outline;
  int value = 0;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: '');
    valueController = TextEditingController(text: '0.00');
    selectedIcon = Icons.add_circle_outline;
  }

  void openIconSelectionModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select an Icon'),
          content: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Icons.shopping_cart,
              Icons.fastfood,
              Icons.directions_car,
              Icons.home,
              Icons.sports_soccer,
              Icons.phone_android,
              Icons.fitness_center,
              Icons.local_gas_station,
              Icons.movie,
            ].map((icon) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIcon = icon;
                    value = icon.codePoint;
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Icon(icon, size: 30, color: Colors.black),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Payment')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  hintText: "Payment name",
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: valueController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: "Value",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: openIconSelectionModal,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(selectedIcon, size: 24, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Map<String, dynamic> newPayment = {};
            newPayment['name_payment'] = titleController.text;
            newPayment['value'] = double.parse(valueController.text);
            newPayment['iconCode'] = selectedIcon.codePoint.toString();
            Navigator.of(context).pop((newPayment));
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
