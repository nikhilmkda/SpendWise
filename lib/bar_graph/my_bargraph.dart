import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
//initialize the bar data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initializeBardata();
    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: const FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, getTitlesWidget: getBottomTiles),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: myBarData.bardata
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    toY: data.y,
                    color: Colors.yellow[900],
                    width: 15,
                    borderRadius: BorderRadius.circular(3),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, toY: maxY, color: Colors.green[200])),
              ]))
          .toList(),
    ));
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'sun',
        style: style,
      );

      break;
    case 1:
      text = const Text(
        'mon',
        style: style,
      );

      break;
    case 2:
      text = const Text(
        'tue',
        style: style,
      );

      break;
    case 3:
      text = const Text(
        'wed',
        style: style,
      );

      break;
    case 4:
      text = const Text(
        'thu',
        style: style,
      );

      break;
    case 5:
      text = const Text(
        'fri',
        style: style,
      );

      break;
    case 6:
      text = const Text(
        'sat',
        style: style,
      );

      break;
    default:
      text = const Text(
        '',
        style: style,
      );
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

class MyBarGraphMonthly extends StatelessWidget {
  final double? maxY;
  final double janAmount;
  final double febAmount;
  final double marAmount;
  final double aprAmount;
  final double mayAmount;
  final double junAmount;
  final double julAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  const MyBarGraphMonthly({
    Key? key,
    required this.maxY,
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initialize the bar data
    BarDataMonthly myBarData = BarDataMonthly(
      janAmount: janAmount,
      febAmount: febAmount,
      marAmount: marAmount,
      aprAmount: aprAmount,
      mayAmount: mayAmount,
      junAmount: junAmount,
      julAmount: julAmount,
      augAmount: augAmount,
      sepAmount: sepAmount,
      octAmount: octAmount,
      novAmount: novAmount,
      decAmount: decAmount,
    );
    myBarData.initializeBarDataMonthly();

    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: const FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, getTitlesWidget: getBottomTilesMonthly),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: myBarData.barDataMonthly
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    toY: data.y,
                    color: Colors.yellow[800],
                    width: 12,
                    borderRadius: BorderRadius.circular(3),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, toY: maxY, color: Colors.green[200])),
              ]))
          .toList(),
    ));
  }
}

Widget getBottomTilesMonthly(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Jan',
        style: style,
      );

      break;
    case 1:
      text = const Text(
        'Feb',
        style: style,
      );

      break;
    case 2:
      text = const Text(
        'mar',
        style: style,
      );

      break;
    case 3:
      text = const Text(
        'Apr',
        style: style,
      );

      break;
    case 4:
      text = const Text(
        'May',
        style: style,
      );

      break;
    case 5:
      text = const Text(
        'Jun',
        style: style,
      );

      break;
    case 6:
      text = const Text(
        'Jul',
        style: style,
      );

      break;

    case 7:
      text = const Text(
        'Aug',
        style: style,
      );

      break;
    case 8:
      text = const Text(
        'Sep',
        style: style,
      );

      break;
    case 9:
      text = const Text(
        'Oct',
        style: style,
      );

      break;
    case 10:
      text = const Text(
        'Nov',
        style: style,
      );

      break;
    case 11:
      text = const Text(
        'Dec',
        style: style,
      );

      break;
    default:
      text = const Text(
        '',
        style: style,
      );
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
