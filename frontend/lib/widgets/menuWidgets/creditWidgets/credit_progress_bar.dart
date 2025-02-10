import 'package:flutter/material.dart';

class CreditProgressBarWidget extends StatefulWidget {
  final double creditUsed;
  final double credit;
  final double percent;
  const CreditProgressBarWidget(
      {super.key,
      required this.creditUsed,
      required this.credit,
      required this.percent});

  @override
  CreditWidgetState createState() => CreditWidgetState();
}

class CreditWidgetState extends State<CreditProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 159, 159, 160),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: widget.percent,
          heightFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 204, 113),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: widget.percent,
          heightFactor: 0.8,
          child: Center(
            child: Offstage(
              offstage: widget.percent <= 0.13,
              child: SizedBox(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: widget.percent >= 0.22
                        ? EdgeInsetsDirectional.only(start: 10)
                        : EdgeInsetsDirectional.only(start: 5),
                    child: Text(
                      widget.creditUsed.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: widget.percent >= 0.22 ? 26 : 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
