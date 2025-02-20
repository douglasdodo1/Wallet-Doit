import 'package:flutter/material.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/card_payment_widget.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/modal_new_payment.dart';
import 'paymentWidgets/modal_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentListWidget extends StatefulWidget {
  const PaymentListWidget({super.key});

  @override
  PaymentListWidgetState createState() => PaymentListWidgetState();
}

class PaymentListWidgetState extends State<PaymentListWidget> {
  List payments = [];
  var payment = {'name_payment': '', 'value': '', 'iconCode': ''};

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.212:3000/read-all-payment-list'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDAxOTc3MCwiZXhwIjoxNzQwMDIzMzcwfQ.hA6F7qT2n4Uf3suujSuIbsYkC1ky6iww52b3iOoqEH8',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      setState(() {
        var data = json.decode(response.body);
        payments = data;
      });
    }
  }

  Future<void> sendData(payment) async {
    final response = await http.post(
        Uri.parse('http://192.168.18.212:3000/create-payment-list'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDAxOTc3MCwiZXhwIjoxNzQwMDIzMzcwfQ.hA6F7qT2n4Uf3suujSuIbsYkC1ky6iww52b3iOoqEH8',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(payment));

    if (response.statusCode == 200) {
      var f = jsonDecode(response.body);
      print("The payment: $f");
    } else {
      print(
          "Erro ao enviar pagamento: ${response.statusCode} - ${response.body}");
    }
  }

  bool _isDragging = false;
  final GlobalKey _trashKey = GlobalKey();
  final ValueNotifier<bool> _isOverTrashNotifier = ValueNotifier<bool>(false);

  void _showPaymentModal(String name, double value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalWidget(paymentName: name, paymentValue: value);
      },
    );
  }

  void _showNewPaymentModal(payment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalNewPayment(
          payment: payment,
        );
      },
    ).then((_) => sendData(payment)).then((_) => fetchData());
  }

  int _getIconCode(code) {
    if (code == null || code == '') {
      return 58136;
    }

    return int.parse(code);
  }

  bool _checkIfInsideTrash(Offset position) {
    final RenderBox? trashBox =
        _trashKey.currentContext?.findRenderObject() as RenderBox?;

    if (trashBox != null) {
      final Offset trashPosition = trashBox.localToGlobal(Offset.zero);
      final Size trashSize = trashBox.size;

      bool inside = position.dx >= trashPosition.dx &&
          position.dx <= trashPosition.dx + trashSize.width &&
          position.dy >= trashPosition.dy &&
          position.dy <= trashPosition.dy + trashSize.height;

      return inside;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.8,
      child: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => _showNewPaymentModal(payment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 250, 250, 250),
                    elevation: 0,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      const Text("Payment list"),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text('02/25',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                    ),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      int iconCode =
                          _getIconCode((payments[index]['iconCode']));
                      return Draggable<Object>(
                        data: payments[index]['name_payment'] as String?,
                        onDragStarted: () {
                          setState(() {
                            _isDragging = true;
                          });
                        },
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        onDragUpdate: (details) {
                          bool isInside =
                              _checkIfInsideTrash(details.globalPosition);
                          _isOverTrashNotifier.value = isInside;
                        },
                        onDragCompleted: () {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: CardPaymentWidget(
                              paymentName: payments[index]['name_payment'],
                              iconCode: iconCode),
                        ),
                        feedback: ValueListenableBuilder<bool>(
                          valueListenable: _isOverTrashNotifier,
                          builder: (context, isOverTrash, child) {
                            return Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CardPaymentWidget(
                                  paymentName: payments[index]['name_payment'],
                                  iconCode: iconCode,
                                ),
                              ),
                            );
                          },
                        ),
                        child: GestureDetector(
                          onTap: () => _showPaymentModal(
                            payments[index]
                                ['name_payment'], // Use o índice do mapa
                            50.00,
                          ),
                          child: CardPaymentWidget(
                            paymentName: payments[index]['name_payment'],
                            iconCode: iconCode,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Lixeira centralizada
                if (_isDragging)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDragging = false;
                          });
                        },
                        child: Container(
                          key: _trashKey,
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
