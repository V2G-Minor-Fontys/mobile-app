import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UsageLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: 2,
          verticalInterval: 6,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 0.5,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 0.5,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                final style = TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                );
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = '06:00';
                    break;
                  case 6:
                    text = '12:00';
                    break;
                  case 12:
                    text = '18:00';
                    break;
                  case 18:
                    text = '00:00';
                    break;
                  default:
                    return Container();
                }
                return Text(text, style: style);
              },
              interval: 6,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final style = TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                );
                String text;
                if (value == 0) {
                  text = '0 kW';
                } else if (value == 2) {
                  text = '2 kW';
                } else if (value == 4) {
                  text = '4 kW';
                } else {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(text, style: style),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 24,
        minY: 0,
        maxY: 5,
        lineBarsData: [
          // Home electricity usage line (blue)
          LineChartBarData(
            spots: [
              FlSpot(0, 1.2),
              FlSpot(3, 1.5),
              FlSpot(6, 2.0),
              FlSpot(9, 2.8),
              FlSpot(12, 2.5),
              FlSpot(15, 3),
              FlSpot(18, 1.8),
              FlSpot(21, 2.8),
              FlSpot(24, 2.8),
            ],
            isCurved: true,
            color: Colors.green.withOpacity(0.9),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.2),
            ),
          ),
          // EV usage line (green)
          LineChartBarData(
            spots: [
              FlSpot(0, 0),
              FlSpot(3, 0),
              FlSpot(6, 0),
              FlSpot(9, 0),
              FlSpot(12, 0),
              FlSpot(15, 0.3),
              FlSpot(18, 2.8),
              FlSpot(21, 2.8),
              FlSpot(24, 2.8),
            ],
            isCurved: true,
            color: Colors.red.withOpacity(0.9),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.3),
            ),
          ),
          // Grid power line (orange)
          LineChartBarData(
            spots: [
              FlSpot(0, 3.0),
              FlSpot(3, 3.0),
              FlSpot(6, 3.0),
              FlSpot(9, 3.0),
              FlSpot(12, 3.0),
              FlSpot(15, 3),
              FlSpot(18, 1.5),
              FlSpot(21, 0.2),
              FlSpot(24, 0.0),
            ],
            isCurved: true,
            color: Colors.blue.withOpacity(0.9),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Colors.black.withOpacity(0.8),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                String unit = ' kW';
                Color color;
                String name;

                if (spot.barIndex == 0) {
                  color = Colors.green;
                  name = 'Home';
                } else if (spot.barIndex == 1) {
                  color = Colors.red;
                  name = 'EV';
                } else {
                  color = Colors.blue;
                  name = 'Grid';
                }

                return LineTooltipItem(
                  '$name: ${spot.y.toStringAsFixed(1)}$unit',
                  TextStyle(color: color, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
