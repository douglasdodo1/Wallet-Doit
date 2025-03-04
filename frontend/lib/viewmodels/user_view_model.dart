import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/payment_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserViewModel extends ChangeNotifier {
  UserModel user = UserModel(
      name: '',
      email: '',
      phone: '',
      sale: 100.00,
      credit: 100.00,
      creditUsed: 10.00);
  List<PaymentModel> payments = [];

  Future<void> fetchUser() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.212:3000/user'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MTEyMzYwNCwiZXhwIjoxNzQxMTI3MjA0fQ.9bVK1U-uwIqx1VXwikAcREnyewFnuzQik1yBi7oAj_c',
        'Content-Type': 'application/json',
      },
    );
    var data = jsonDecode(response.body);
    user = UserModel.fromJson(data);
    notifyListeners();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.212:3000/payments/all'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MTExNzU5MiwiZXhwIjoxNzQxMTIxMTkyfQ.dv8lR_73BMSpvAsbShI-NjIX_jjstkVt2m5vPp8vD6A',
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

  List<PaymentModel> _filterPaymentsByDate(List<PaymentModel> paymentsList) {
    List<PaymentModel> tempPayments = paymentsList.where((element) {
      String formattedDate = DateFormat('MM/yyyy').format(DateTime.now());
      String paymentDate = element.createdAt!.substring(5, 7);
      String actualMonth = formattedDate.substring(0, 2);
      String actualPaymentMonth = paymentDate.substring(0, 2);

      return actualMonth == actualPaymentMonth;
    }).toList();
    return tempPayments;
  }
}
