import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CashflowChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 30000,

          minY: 0,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];
                  return Transform.rotate(
                    angle:
                        -0.5, // approx -28.6 degrees, bottom left to top right
                    child: Text(
                      months[value.toInt()],
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
                reservedSize: 28,
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              drawBelowEverything: true,
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
              drawBelowEverything: true,
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // show: true,
          ),
          gridData: FlGridData(show: false, drawHorizontalLine: true),
          borderData: FlBorderData(show: false),

          barGroups: List.generate(12, (index) {
            final moneyIn = [
              3000,
              6000,
              8000,
              10000,
              15000,
              10000,
              12000,
              17000,
              16000,
              22000,
              20000,
              25000,
            ];
            final moneyOut = [
              2000,
              4000,
              5000,
              8000,
              10000,
              8000,
              9000,
              12000,
              11000,
              18000,
              17000,
              19000,
            ];
            return BarChartGroupData(
              x: index,

              barRods: [
                BarChartRodData(
                  toY: moneyIn[index].toDouble(),
                  color: Color(0xFF1E90FF),
                  width: 15,
                  borderRadius: BorderRadius.zero,
                ),
                BarChartRodData(
                  toY: moneyOut[index].toDouble(),
                  color: Color.fromRGBO(30, 144, 255, 0.5),
                  width: 15,
                  borderRadius: BorderRadius.zero,
                ),
              ],
              barsSpace: 4,
            );
          }),
        ),
      ),
    );
  }
}
