import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MouthPayment extends StatefulWidget {
  final Map<int, double> paymentValues;
  const MouthPayment({
    super.key,
    required this.paymentValues,
  });

  @override
  MouthPaymentState createState() => MouthPaymentState();
}

class MouthPaymentState extends State<MouthPayment> {
  double calculateInterval(List<double> numbers) {
    double bigger = numbers.reduce((a, b) => a > b ? a : b);

    double interval = bigger / 5;
    if (interval == 0) {
      interval = 1;
    }
    return interval;
  }

  String getMonthAbbreviation(int month) {
    if (month < 1 || month > 12) {
      return 'Mês inválido';
    }

    // Obter a sigla do mês (primeiras 3 letras)
    DateFormat dateFormat = DateFormat('MMM');
    String monthAbbreviation = dateFormat.format(DateTime(2025, month));

    return monthAbbreviation;
  }

  @override
  void initState() {
    super.initState();
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
            barGroups: widget.paymentValues.entries.map((entry) {
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
                  interval:
                      calculateInterval(widget.paymentValues.values.toList()),
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
                    if (index >= 0 && index <= widget.paymentValues.length) {
                      return Text(
                        //months[index],
                        getMonthAbbreviation(index),
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
