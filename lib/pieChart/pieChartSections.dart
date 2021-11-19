import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:financemanager2/pieChart/pieChartSectionsData.dart';
import 'package:financemanager2/transactions.dart';

List<PieChartSectionData>? getSections(int touchedIndex, List list) =>
    Transactions()
        .createSectionDataList(list)
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final double total = data.total;
          final double fontSize = isTouched ? 18 : 15;
          final double radius = isTouched ? 40 : 20;
          final value = PieChartSectionData(
              value: data.percent,
              color: data.color,
              title: data.categoryInSection,
              radius: radius,
              showTitle: false,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
              badgeWidget: touchedIndex != -1
                  ? touchedIndex == index
                      ? Icon(
                          getIcon(data.categoryInSection),
                          size: 32,
                        )
                      : Text('')
                  : Text(''));
          return MapEntry(index, value);
        })
        .values
        .toList();

int touchedIndex = -1;
List<IconData> icons = [
  Icons.local_grocery_store,
  Icons.work,
  Icons.casino,
  Icons.fastfood,
  Icons.videogame_asset,
  Icons.blur_on_rounded
];
List<String> categories = [
  'Groceries',
  'Business',
  'Entertainment',
  'Meals',
  'Gaming',
  'Empty'
];

IconData getIcon(String category) {
  IconData icon = Icons.category;
  for (int i = 0; i <= 5; i++) {
    if (category == categories[i]) {
      icon = icons[i];
    }
  }
  return icon;
}

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
