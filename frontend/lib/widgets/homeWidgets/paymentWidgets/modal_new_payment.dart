import 'package:flutter/material.dart';

class ModalNewPayment extends StatefulWidget {
  final Map<String, dynamic> payment;

  ModalNewPayment({super.key, required this.payment});

  @override
  ModalNewPaymentState createState() => ModalNewPaymentState();
}

class ModalNewPaymentState extends State<ModalNewPayment> {
  late TextEditingController titleController;
  late TextEditingController valueController;
  IconData? selectedIcon;
  int value = 0;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.payment['name_payment'] ?? '');
    valueController = TextEditingController(
        text: widget.payment['value'] != null
            ? widget.payment['value'].toString()
            : '0');

    widget.payment['name_payment'] = '';
    widget.payment['value'] = '0.00';

    selectedIcon = Icons.add_circle_outline;
    widget.payment['iconCode'] = selectedIcon?.codePoint.toString();

    titleController.addListener(() {
      widget.payment['name_payment'] = titleController.text;
    });

    valueController.addListener(() {
      double parsedValue = double.tryParse(valueController.text) ?? 0.00;
      parsedValue = double.parse(parsedValue.toStringAsFixed(2));
      setState(() {
        widget.payment['value'] = parsedValue.toString();
      });
    });
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
                    print(value);
                  });
                  print('Selecionado: ${icon.codePoint}');
                  setState(() {
                    widget.payment['iconCode'] = value.toString();
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
            print(widget.payment['value']);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
