import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MouthPayment extends StatefulWidget {
  const MouthPayment({super.key});

  @override
  MouthPaymentState createState() => MouthPaymentState();
}

class MouthPaymentState extends State<MouthPayment> {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
  ];

  final List<double> payments = [
    100,
    200,
    150,
    180,
    120,
    90,
    500,
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: BarChart(
            BarChartData(
              barGroups: payments.asMap().entries.map((entry) {
                final index = entry.key;
                final value = entry.value;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      color: Colors.blue,
                      width: 20,
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval:
                        50, // Ajuste o intervalo para evitar sobrecarga de títulos
                    reservedSize:
                        35, // Ajuste o espaço reservado para os títulos do lado esquerdo
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
                          style: const TextStyle(fontSize: 12),
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
                enabled: false, // Desativa todas as interações com as barras
              ),
            ),
          ),
        ),
      ),
    );
  }
}
