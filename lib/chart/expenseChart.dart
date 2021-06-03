import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'pieChartSections.dart';
import 'indicator.dart';

class ExpenseChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExpenseChartState();
}

class ExpenseChartState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return
        // return Column(
        //   children: <Widget>[
        PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (pieTouchResponse) {
            setState(() {
              final desiredTouch =
                  pieTouchResponse.touchInput is! PointerExitEvent &&
                      pieTouchResponse.touchInput is! PointerUpEvent;
              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              } else {
                touchedIndex = -1;
              }
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: double.infinity,
        sections: getSections(touchedIndex),
      ),
    );
    // SizedBox(
    //   height: 5,
    // ),
    // Padding(
    //   padding: const EdgeInsets.all(16),
    //   child: IndicatorsWidget(),
    // ),
    //   ],
    // );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return FlChart(
//       seriesList,
//       animate: animate,
//       animationDuration: Duration(seconds: 1),
//       defaultRenderer: charts.ArcRendererConfig(
//         arcWidth: 12,
//         strokeWidthPx: 0,
//         arcRendererDecorators: [
//           charts.ArcLabelDecorator(
//             labelPadding: 0,
//             showLeaderLines: false,
//             outsideLabelStyleSpec: charts.TextStyleSpec(
//               fontSize: 12,
//               fontFamily: 'sans-serif',
//               color: charts.MaterialPalette.white,
//             ),
//           ),
//         ],
//       ),
//       behaviors: [
//         charts.DatumLegend(
//           position: charts.BehaviorPosition.end,
//           outsideJustification: charts.OutsideJustification.start,
//           horizontalFirst: false,
//           desiredMaxColumns: 1,
//           cellPadding: const EdgeInsets.only(right: 4, bottom: 4),
//           entryTextStyle: charts.TextStyleSpec(
//             fontSize: 12,
//             color: charts.MaterialPalette.white,
//           ),
//         )
//       ],
//     );
//   }
// }
