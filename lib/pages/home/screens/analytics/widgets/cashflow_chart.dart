import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CashflowChart extends StatelessWidget {
  const CashflowChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CashflowData> chartData = [
      CashflowData('Jan', 3000, 2000),
      CashflowData('Feb', 6000, 4000),
      CashflowData('Mar', 8000, 5000),
      CashflowData('Apr', 10000, 8000),
      CashflowData('May', 15000, 10000),
      CashflowData('Jun', 10000, 8000),
      CashflowData('Jul', 12000, 9000),
      CashflowData('Aug', 17000, 12000),
      CashflowData('Sep', 16000, 11000),
      CashflowData('Oct', 22000, 18000),
      CashflowData('Nov', 20000, 17000),
      CashflowData('Dec', 25000, 19000),
    ];

    return AspectRatio(
      aspectRatio: 1.7,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: -30,
          labelStyle: const TextStyle(fontSize: 10),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0),
        ),
        primaryYAxis: NumericAxis(isVisible: false, maximum: 30000, minimum: 0),
        plotAreaBorderWidth: 0,
        series: <CartesianSeries<CashflowData, String>>[
          ColumnSeries<CashflowData, String>(
            dataSource: chartData,
            xValueMapper: (CashflowData data, _) => data.month,
            yValueMapper: (CashflowData data, _) => data.moneyIn,
            color: const Color(0xFF1E90FF),
            width: 0.4,
            spacing: 0.1,
            borderRadius: BorderRadius.zero,
          ),
          ColumnSeries<CashflowData, String>(
            dataSource: chartData,
            xValueMapper: (CashflowData data, _) => data.month,
            yValueMapper: (CashflowData data, _) => data.moneyOut,
            color: const Color.fromRGBO(30, 144, 255, 0.5),
            width: 0.4,
            spacing: 0.1,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    );
  }
}

class CashflowData {
  CashflowData(this.month, this.moneyIn, this.moneyOut);
  final String month;
  final double moneyIn;
  final double moneyOut;
}
