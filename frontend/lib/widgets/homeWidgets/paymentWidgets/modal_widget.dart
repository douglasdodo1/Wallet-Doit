import 'package:flutter/material.dart';

class ModalWidget extends StatefulWidget {
  Map<String, dynamic> editedPayment = {};

  ModalWidget({
    super.key,
    required this.editedPayment,
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
    titleController =
        TextEditingController(text: widget.editedPayment['name_payment']);
    valueController = TextEditingController(
        text: widget.editedPayment['value'].toStringAsFixed(2));

    titleController.addListener(() => setState(() {
          widget.editedPayment['name_payment'] = titleController.text;
        }));

    valueController.addListener(() => setState(() {
          widget.editedPayment['value'] = double.parse(valueController.text);
        }));
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
