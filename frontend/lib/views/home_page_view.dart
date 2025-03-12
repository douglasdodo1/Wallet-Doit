import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/user_view_model.dart';
import 'package:frontend/views/bottom_bar_view.dart';
import 'package:frontend/views/payment_list_view.dart';
import 'package:frontend/widgets/menuWidgets/creditWidgets/credit_widget.dart';
import 'package:frontend/widgets/homeWidgets/debit_widget.dart';
import 'package:frontend/widgets/homeWidgets/month_payment.dart';
import 'package:provider/provider.dart';

class MyHomePageView extends StatefulWidget {
  const MyHomePageView({super.key});

  @override
  MyHomePageViewState createState() => MyHomePageViewState();
}

class MyHomePageViewState extends State<MyHomePageView> {
  @override
  void initState() {
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    userViewModel.fetchUser();
    userViewModel.fetchData().then((_) {
      userViewModel.filterPaymentsByDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 250, 250, 250),
            toolbarHeight: 150,
            title: DebitWidget(debit: userViewModel.user.sale)),
        body: SizedBox.expand(
          child: Column(
            children: <Widget>[
              Container(
                height: 2,
                color: Colors.black,
              ),
              Expanded(
                flex: 3,
                child: Container(
                    color: Color.fromARGB(255, 250, 250, 250),
                    child: CreditWidget(
                        creditUsed: userViewModel.user.creditUsed,
                        credit: userViewModel.user.credit)),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    color: Color.fromARGB(255, 250, 250, 250),
                    child: MouthPayment(
                        paymentValues: userViewModel.filterPaymentsByDate())),
              ),
              Container(
                height: 2,
                color: Colors.black,
              ),
              Expanded(
                flex: 4,
                child: Container(
                    color: Color.fromARGB(255, 250, 250, 250),
                    child: PaymentListView()),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomBarView(payments: userViewModel.payments),
      );
    });
  }
}
