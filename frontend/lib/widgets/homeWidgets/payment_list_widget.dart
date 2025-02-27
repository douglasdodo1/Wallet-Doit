import 'package:flutter/material.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/card_payment_widget.dart';
import 'package:frontend/widgets/homeWidgets/paymentWidgets/modal_new_payment.dart';
import 'paymentWidgets/modal_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaymentListWidget extends StatefulWidget {
  const PaymentListWidget({super.key});

  @override
  PaymentListWidgetState createState() => PaymentListWidgetState();
}

class PaymentListWidgetState extends State<PaymentListWidget> {
  List payments = [];
  bool _isDragging = false;
  final GlobalKey _trashKey = GlobalKey();
  final ValueNotifier<bool> _isOverTrashNotifier = ValueNotifier<bool>(false);
  Map<String, dynamic> draggedPayment = {};
  String formattedDate = '';

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.212:3000/payments/all'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDYyNzgyNiwiZXhwIjoxNzQwNjMxNDI2fQ.mHe-4WL-cZDUCIWr-AhonqIlsAgSQj_3SXNkbP_Kp5A',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      payments = data;

      setState(() {
        payments = _getToDate(payments);
      });
    }
  }

  Future<void> sendData(payment) async {
    await http.post(Uri.parse('http://192.168.18.212:3000/payments'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDYyNzgyNiwiZXhwIjoxNzQwNjMxNDI2fQ.mHe-4WL-cZDUCIWr-AhonqIlsAgSQj_3SXNkbP_Kp5A',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(payment));

    fetchData();
  }

  Future<void> updateData(payment) async {
    String paymentId = payment['id'].toString();
    await http.put(Uri.parse('http://192.168.18.212:3000/payment/$paymentId'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDYyNzgyNiwiZXhwIjoxNzQwNjMxNDI2fQ.mHe-4WL-cZDUCIWr-AhonqIlsAgSQj_3SXNkbP_Kp5A',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(payment));
  }

  Future<void> deleteData(String paymentId) async {
    await http.delete(
      Uri.parse('http://192.168.18.212:3000/payments/$paymentId'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MDYyNzgyNiwiZXhwIjoxNzQwNjMxNDI2fQ.mHe-4WL-cZDUCIWr-AhonqIlsAgSQj_3SXNkbP_Kp5A',
        'Content-Type': 'application/json'
      },
    );

    fetchData();
  }

  List _getToDate(paymentsList) {
    List tempPayments = paymentsList.where((element) {
      String paymentDate = element['createdAt'].substring(5, 7);
      String actualMonth = formattedDate.substring(0, 2);
      String actualPaymentMonth = paymentDate.substring(0, 2);

      return actualMonth == actualPaymentMonth;
    }).toList();
    return tempPayments;
  }

  void _showPaymentModal(payment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalWidget(editedPayment: payment);
      },
    ).then((_) => updateData(payment));
  }

  void _showNewPaymentModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalNewPayment();
      },
    ).then((result) {
      Map<String, dynamic> newPayment = result;
      sendData(newPayment);
    });
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

      bool inside = position.dx >= trashPosition.dx - 10 &&
          position.dx <= trashPosition.dx + trashSize.width + 10 &&
          position.dy >= trashPosition.dy + 10 &&
          position.dy <= trashPosition.dy + trashSize.height + 10;

      return inside;
    }
    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showMonthPicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2025),
          lastDate: DateTime(2100),
        ) ??
        DateTime.now();

    setState(() {
      formattedDate = DateFormat('MM/yyyy').format(picked);
    });
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    formattedDate = DateFormat('MM/yyyy').format(date);
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
                  onPressed: () => _showNewPaymentModal(),
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
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 250, 250, 250),
                      side: BorderSide.none,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
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
                            draggedPayment = payments[index];
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
                        onDragEnd: (details) {
                          if (_isOverTrashNotifier.value) {
                            deleteData(draggedPayment['id'].toString());
                          }
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
                                width: _isOverTrashNotifier.value ? 100 : 90,
                                height: _isOverTrashNotifier.value ? 100 : 90,
                                child: CardPaymentWidget(
                                  paymentName: payments[index]['name_payment'],
                                  iconCode: iconCode,
                                ),
                              ),
                            );
                          },
                        ),
                        child: GestureDetector(
                          onTap: () => _showPaymentModal(payments[index]),
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
                          width: 100,
                          height: 100,
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
                            size: 100,
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
