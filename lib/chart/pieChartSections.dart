import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:financemanager2/pieChartSectionsData.dart';
import 'package:financemanager2/transactions.dart';

List<PieChartSectionData>? getSections(int touchedIndex) => Transactions()
    .createSectionDataList()
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 18 : 15;
      final double radius = isTouched ? 40 : 20;
      final value = PieChartSectionData(
        value: data.percent,
        color: data.color,
        title: '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();

// class Expense extends StatelessWidget {
//   final String category;
//   final double value;
//   final bool isSquare;
//   final Color textColor;
//   final Color color;
//
//   const Expense({
//     Key? key,
//     required this.color,
//     required this.category,
//     required this.isSquare,
//     this.value = 16,
//     this.textColor = const Color(0xff505050),
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: value,
//           height: value,
//           decoration: BoxDecoration(
//             shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
//             color: color,
//           ),
//         ),
//         SizedBox(
//           width: 4,
//         ),
//         Text(
//           category,
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
//         )
//       ],
//     );
//   }
// }
