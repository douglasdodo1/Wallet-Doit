import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class MouthPayment extends StatefulWidget {
  const MouthPayment({super.key});

  @override
  MouthPaymentState createState() => MouthPaymentState();
}

class MouthPaymentState extends State<MouthPayment> {
  List months = ['jan', 'feb', 'marc', 'april', 'mai', 'jun'];

  final List<double> paymentsValues = [
    100,
    200,
    150,
    180,
    120,
    90,
    500,
  ];

  double calculateInterval(List<double> numbers) {
    double bigger = numbers.reduce((a, b) => a > b ? a : b);
    return bigger / 5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 20, 2, 0),
        child: BarChart(
          BarChartData(
            barGroups: paymentsValues.asMap().entries.map((entry) {
              final index = entry.key;
              final value = entry.value;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
                    color: const Color.fromARGB(255, 0, 168, 107),
                    width: 33,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ],
              );
            }).toList(),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: calculateInterval(paymentsValues),
                  reservedSize: 35,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}',
                      style: const TextStyle(fontSize: 14),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < months.length) {
                      return Text(
                        months[index],
                        style: const TextStyle(fontSize: 15),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border.symmetric(
                horizontal: BorderSide(color: Colors.black),
                vertical: BorderSide(color: Colors.black),
              ),
            ),
            gridData: FlGridData(show: true),
            barTouchData: BarTouchData(
              enabled: false,
            ),
          ),
        ),
      ),
    );
  }
}
