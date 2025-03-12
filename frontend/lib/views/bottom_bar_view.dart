import 'package:flutter/material.dart';
import 'package:frontend/models/payment_model.dart';
import 'package:frontend/views/home_page_view.dart';
import 'package:frontend/views/notifications_view.dart';

class BottomBarView extends StatefulWidget {
  late List<PaymentModel> payments;
  BottomBarView({super.key, required this.payments});
  @override
  BottomBarViewState createState() => BottomBarViewState();
}

class BottomBarViewState extends State<BottomBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 250, 250),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePageView()));
                },
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 60,
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationsView(payments: widget.payments)));
                },
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 60,
                ),
              ),
            ),
          ]),
        ));
  }
}
