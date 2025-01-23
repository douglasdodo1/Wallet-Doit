import 'package:flutter/material.dart';

import 'credit_progress_bar.dart';

class CreditWidget extends StatefulWidget {
  final double creditUsed;
  final double credit;
  const CreditWidget(
      {super.key, required this.creditUsed, required this.credit});

  @override
  CreditWidgetState createState() => CreditWidgetState();
}

class CreditWidgetState extends State<CreditWidget> {
  double _calculatePercentUsed(double usedValue, double totalValue) {
    double percent = (usedValue) / totalValue;
    return percent < 0.08 && percent > 0 ? 0.055 : percent;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Column(
        children: [
          const Text(
            'CREDIT',
            style: TextStyle(
              fontSize: 42,
              fontFamily: 'Open Sans',
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: Text(
                            'R\$${widget.credit.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CreditProgressBarWidget(
              creditUsed: widget.creditUsed,
              credit: widget.credit,
              percent: _calculatePercentUsed(widget.creditUsed, widget.credit),
            ),
          ),
        ],
      ),
    );
  }
}
