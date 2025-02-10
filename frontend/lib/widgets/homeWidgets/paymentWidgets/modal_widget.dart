import 'package:flutter/material.dart';

class ModalWidget extends StatefulWidget {
  final String paymentName;
  final double paymentValue;

  const ModalWidget({
    super.key,
    required this.paymentName,
    required this.paymentValue,
  });

  @override
  ModalWidgetState createState() => ModalWidgetState();
}

class ModalWidgetState extends State<ModalWidget> {
  late TextEditingController titleController;
  late TextEditingController valueController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.paymentName);
    valueController =
        TextEditingController(text: widget.paymentValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: TextField(
          controller: titleController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(border: InputBorder.none),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
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
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
