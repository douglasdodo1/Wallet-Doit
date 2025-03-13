import 'package:flutter/material.dart';
import 'package:frontend/models/payment_model.dart';

// ignore: must_be_immutable
class NotificationsView extends StatefulWidget {
  final List<PaymentModel> payments;
  const NotificationsView({super.key, required this.payments});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<PaymentModel> filteredPayments = [];

  @override
  void initState() {
    super.initState();
    filterByTime();
  }

  void filterByTime() {
    int currentDay = DateTime.now().day;

    List<PaymentModel> tempPayments = widget.payments.where((element) {
      int paymentDay = int.parse(element.createdAt!.substring(8, 10));
      print('$currentDay,${element.createdAt!.substring(8, 10)}');
      return paymentDay - currentDay <= 7 && paymentDay - currentDay > 0;
    }).toList();

    setState(() {
      filteredPayments = tempPayments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
        centerTitle: true,
      ),
      body: filteredPayments.isEmpty
          ? const Center(child: Text("Nenhuma notificação disponível"))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredPayments.length, // Usa os dados filtrados
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(filteredPayments[index].namePayment),
                    onTap: () {
                      // Ação ao tocar na notificação
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Você abriu: ${filteredPayments[index].namePayment}")),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
