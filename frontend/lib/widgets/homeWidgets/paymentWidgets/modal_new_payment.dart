import 'package:flutter/material.dart';
import 'package:frontend/models/payment_model.dart';
import 'package:intl/intl.dart';

class ModalNewPayment extends StatefulWidget {
  ModalNewPayment({super.key});

  static Future<PaymentModel> showNewPaymentModal(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalNewPayment();
      },
    );
  }

  @override
  ModalNewPaymentState createState() => ModalNewPaymentState();
}

class ModalNewPaymentState extends State<ModalNewPayment> {
  late TextEditingController titleController;
  late TextEditingController valueController;
  late TextEditingController dateController;
  IconData selectedIcon = Icons.add_circle_outline;
  int value = 0;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    valueController = TextEditingController();
    dateController = TextEditingController();
  }

  void openIconSelectionModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione um Ícone'),
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

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    valueController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Novo Pagamento')),
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
                  hintText: "Nome do Pagamento",
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
                        hintText: "Valor",
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
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: dateController,
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Selecione uma Data",
                ),
                onTap: selectDate,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            PaymentModel newPayment = PaymentModel(
              namePayment: titleController.text,
              value: double.parse(valueController.text),
              iconCode: selectedIcon.codePoint.toString(),
              createdAt: dateController.text,
            );
            Navigator.of(context).pop(newPayment);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
