import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/payment_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaymentViewModel extends ChangeNotifier {
  List<PaymentModel> payments = [];
  String formattedDate = DateFormat('MM/yyyy').format(DateTime.now());
  final String baseUrl = 'http://192.168.18.212:3000';
  bool isDragging = false;
  final GlobalKey trashKey = GlobalKey();
  final ValueNotifier<bool> isOverTrashNotifier = ValueNotifier<bool>(false);
  late PaymentModel draggedPayment;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MTI5NDk5OSwiZXhwIjoxNzQxMjk4NTk5fQ.3GkuOOgt7n3rZ-5GfGnimWeou5sCiynOpCTwHrnRcPQ';

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.212:3000/payments/all'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      payments = List<PaymentModel>.from(
          data.map((element) => PaymentModel.fromJson(element)));
      payments = _filterPaymentsByDate(payments);
      notifyListeners();
    }
  }

  Future<void> sendData(PaymentModel payment) async {
    await http.post(Uri.parse('http://192.168.18.212:3000/payments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(payment.removeNulls()));

    fetchData();
  }

  Future<void> updateData(payment) async {
    String paymentId = payment['id'].toString();
    await http.put(Uri.parse('http://192.168.18.212:3000/payment/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(payment));
  }

  Future<void> deleteData(String paymentId) async {
    await http.delete(
      Uri.parse('http://192.168.18.212:3000/payments/$paymentId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    fetchData();
  }

  List<PaymentModel> _filterPaymentsByDate(List<PaymentModel> paymentsList) {
    List<PaymentModel> tempPayments = paymentsList.where((element) {
      String paymentDate = element.createdAt!.substring(5, 7);
      String actualMonth = formattedDate.substring(0, 2);
      String actualPaymentMonth = paymentDate.substring(0, 2);

      return actualMonth == actualPaymentMonth;
    }).toList();
    return tempPayments;
  }

  static int getIconCode(code) {
    if (code == null || code == '') {
      return 58136;
    }

    return int.parse(code);
  }

  bool checkIfInsideTrash(Offset position) {
    final RenderBox? trashBox =
        trashKey.currentContext?.findRenderObject() as RenderBox?;

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

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showMonthPicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2025),
          lastDate: DateTime(2100),
        ) ??
        DateTime.now();

    formattedDate = DateFormat('MM/yyyy').format(picked);
    fetchData();
  }
}
