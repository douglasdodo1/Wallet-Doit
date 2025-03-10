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

  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjM0NTY3ODkxMSIsImlhdCI6MTc0MTYzMjExNSwiZXhwIjoxNzQxNjM1NzE1fQ.Gn6RHpqzmYCXDnWN76_PBrpLnPZ_3d2UhrO0EO0vSFk';

  Future<void> fetchUser() async {
    final response = await http.get(
      Uri.parse('http://150.161.197.115:3000/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    var data = jsonDecode(response.body);
    user = UserModel.fromJson(data);
    notifyListeners();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://150.161.197.115:3000/payments/all'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      payments = List<PaymentModel>.from(
          data.map((element) => PaymentModel.fromJson(element)));
      //ayments = _filterPaymentsByDate(payments);
      notifyListeners();
    }
  }

  void sortPaymentsByMonth(List<PaymentModel> payments) {
    payments.sort((a, b) {
      DateTime? dateA =
          a.createdAt != null ? DateTime.tryParse(a.createdAt!) : null;
      DateTime? dateB =
          b.createdAt != null ? DateTime.tryParse(b.createdAt!) : null;

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;

      return dateA.month.compareTo(dateB.month);
    });
  }

  Map<int, double> filterPaymentsByDate() {
    String formattedDate = DateFormat('MM/yyyy').format(DateTime.now());
    List<int> mounths = [];
    int actualMonth = int.parse(formattedDate.substring(0, 2));
    List<PaymentModel> tempPayments = List.from(payments);
    sortPaymentsByMonth(tempPayments);

    Map<int, List<PaymentModel>> organizedPayments = {};

    if (actualMonth > 6) {
      for (var i = actualMonth - 6; i <= actualMonth; i++) {
        mounths.add(i);
      }
    } else {
      for (var i = 1; i <= actualMonth; i++) {
        mounths.add(i);
      }
    }

    for (var mounth in mounths) {
      organizedPayments[mounth] = tempPayments.where((element) {
        return element.createdAt?.substring(5, 7) == '0$mounth';
      }).toList();
    }

    Map<int, double> sumPaymentMounth = {};
    for (var group in organizedPayments.keys) {
      double sum = 0;
      for (var element in organizedPayments[group]!) {
        sum += element.value;
      }
      sumPaymentMounth[group] = sum;
    }

    return sumPaymentMounth;
  }
}
