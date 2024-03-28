import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Controller/report_controller.dart';

class CircularChartView extends StatelessWidget {
   CircularChartView({super.key});

  final ReportController controller = Get.put(ReportController());

   final List<ChartData> chartData = [
      ChartData('David', 85, Color(0xffD2ECD3)),
      ChartData('Steve', 45, Color(0xFFF4747C)),
      ChartData('Jack', 10, Color(0xFFFEFACD)),

    ];

  @override
  Widget build(BuildContext context) {
    return  SfCircularChart(

          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              // selectionBehavior: SelectionBehavior(
              //     enable: true,
              //   unselectedColor: Colors.grey
              //
              // ),
              radius: "80",
              innerRadius: "40",
                // dataSource: controller.check(),
                dataSource: chartData,

                pointColorMapper: (ChartData data, _) =>
                    data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                startAngle: 0, // Starting angle of doughnut
                endAngle: 360 // Ending angle of doughnut
                )
          ],
        );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

// class PresentData{
//   final String cat;
//   final int count;
//   final Color color;
//   PresentData(this.cat,this.count, this.color);
// }