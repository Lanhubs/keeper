import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:keeper/core/controllers/dashboard_controller.dart';

class CashflowChart extends StatelessWidget {
  final RxList<CashflowData>? cashflowData;

  const CashflowChart({super.key, this.cashflowData});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = cashflowData ?? <CashflowData>[].obs;

      if (data.isEmpty) {
        return AspectRatio(
          aspectRatio: 1.7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    'No data available',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return AspectRatio(
        aspectRatio: 1.7,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelRotation: -30,
            labelStyle: const TextStyle(fontSize: 10),
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
          ),
          primaryYAxis: NumericAxis(isVisible: false, minimum: 0),
          plotAreaBorderWidth: 0,
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.x : ₦point.y',
          ),
          series: <CartesianSeries<CashflowData, String>>[
            ColumnSeries<CashflowData, String>(
              dataSource: data,
              xValueMapper: (CashflowData data, _) => data.month,
              yValueMapper: (CashflowData data, _) => data.moneyIn,
              name: 'Money In',
              color: const Color(0xFF1E90FF),
              width: 0.4,
              spacing: 0.1,
              borderRadius: BorderRadius.zero,
            ),
            ColumnSeries<CashflowData, String>(
              dataSource: data,
              xValueMapper: (CashflowData data, _) => data.month,
              yValueMapper: (CashflowData data, _) => data.moneyOut,
              name: 'Money Out',
              color: const Color.fromRGBO(30, 144, 255, 0.5),
              width: 0.4,
              spacing: 0.1,
              borderRadius: BorderRadius.zero,
            ),
          ],
        ),
      );
    });
  }
}
