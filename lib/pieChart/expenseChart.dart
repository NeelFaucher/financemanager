import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'pieChartSections.dart';
import 'package:provider/provider.dart';
import '../transactions.dart';
import 'package:financemanager2/pages/statsPage.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class ExpenseChart extends StatefulWidget {
  final String monthString;

  const ExpenseChart({required this.monthString});

  @override
  State<StatefulWidget> createState() => ExpenseChartState();
}

class ExpenseChartState extends State<ExpenseChart> {
  @override
  void initState() {
    super.initState();
  }

  int i = 0;
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
  int getNoOfTransactionsInCategory(String category, List list) {
    int noOfTransactions = 0;
    for (int i = 0; i < list.length; i++) {
      if (category == list[i].category) {
        noOfTransactions++;
      }
    }
    return noOfTransactions;
  }

  // double getDiffFromLastMonth(double thisMonth, double lastMonth) {
  //   double diff = thisMonth - lastMonth;
  //   return diff;
  // }

  IconData getIcon(String category) {
    IconData icon = Icons.category;
    for (int i = 0; i <= 5; i++) {
      if (category == categories[i]) {
        icon = icons[i];
      }
    }
    return icon;
  }

  Color getColor(String category) {
    Color color = Colors.black.withOpacity(0.05);
    List<Color> colors = [
      Color(0xfffe91ca),
      Color(0xff40bad5),
      Colors.indigo,
      Color(0xffe8505b),
      Color(0xfff6d743),
      Colors.grey.withOpacity(0.1),
    ];
    for (int i = 0; i <= 5; i++) {
      if (category == categories[i]) {
        color = colors[i];
      }
    }
    return color;
  }

  String formatter(DateTime date) {
    DateFormat string = DateFormat('yyyy-MM');
    return string.format(date);
  }

  List<Transaction> getNewList(
      List<Transaction> list, List<Transaction> emptyList, String monthString) {
    List<Transaction> transactionListWDates = [];
    for (int i = 0; i < list.length; i++) {
      if (formatter(list[i].date) == monthString) {
        transactionListWDates.add(list[i]);
      }
    }
    if (transactionListWDates.isEmpty == true) {
      transactionListWDates = emptyList;
    }
    return transactionListWDates;
  }

  @override
  Widget build(BuildContext context) {
    final providedTransactions = Provider.of<Transactions>(context);
    // double differenceFromLastMonthInCategory = getDiffFromLastMonth(
    //     Transactions().getTotalInCategory(
    //         getSections(
    //                     touchedIndex,
    //                     getNewList(
    //                         providedTransactions.transactions, providedTransactions.emptyList, widget.monthString))![
    //                 (touchedIndex != -1) ? touchedIndex : 0]
    //             .title,
    //         getNewList(providedTransactions.transactions,
    //             providedTransactions.emptyList, widget.monthString)),
    //     Transactions().getTotalInCategory(
    //         getSections(
    //                 touchedIndex,
    //                 getNewList(
    //                     providedTransactions.transactions,
    //                     providedTransactions.emptyList,
    //                     widget.prevMonthString))![(touchedIndex != -1) ? touchedIndex : 0]
    //             .title,
    //         getNewList(providedTransactions.transactions, providedTransactions.emptyList, widget.prevMonthString)));
    //
    // double differenceFromLastMonth = getDiffFromLastMonth(
    //     Transactions().getTotal(getNewList(providedTransactions.transactions,
    //         providedTransactions.emptyList, widget.monthString)),
    //     Transactions().getTotal(getNewList(providedTransactions.transactions,
    //         providedTransactions.emptyList, widget.prevMonthString)));
    final mediaQuery = MediaQuery.of(context);
    return
        //make a function that outputs a list and uses the listened to int from stream to provide the list with the list items corresponding to the month
        // return Column(
        //   children: <Widget>[
        Column(
      children: [
        Container(
          height: 320,
          width: mediaQuery.size.width,
          alignment: Alignment.topCenter,
          child: Stack(children: [
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (pieTouchResponse) {
                    setState(() {
                      final desiredTouch =
                          pieTouchResponse.touchInput is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                      if (desiredTouch &&
                          pieTouchResponse.touchedSection != null) {
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
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
                centerSpaceRadius: (touchedIndex == -1) ? 140 : 120,
                sections: getSections(
                    touchedIndex,
                    getNewList(providedTransactions.transactions,
                        providedTransactions.emptyList, widget.monthString)),
              ),
            ),
            Center(
                child: touchedIndex != -1
                    ? AnimatedPadding(
                        padding: const EdgeInsets.all(60.0),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                        child: AnimatedContainer(
                          decoration: new BoxDecoration(
                            color: getSections(
                                    touchedIndex,
                                    getNewList(
                                        providedTransactions.transactions,
                                        providedTransactions.emptyList,
                                        widget.monthString))![touchedIndex]
                                .color
                                .withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          // width: ,
                          // height: 250,
                          curve: Curves.linearToEaseOut,
                          duration: Duration(seconds: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(top: 65, left: 5),

                              Text(
                                  getSections(
                                          touchedIndex,
                                          getNewList(
                                              providedTransactions.transactions,
                                              providedTransactions.emptyList,
                                              widget
                                                  .monthString))![touchedIndex]
                                      .title,
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.blueGrey[500],
                                    letterSpacing: 0.7,
                                    fontWeight: FontWeight.bold,
                                  )),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.pie_chart,
                                        size: 23, color: Colors.blueGrey[500]),
                                    Text(':',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.blueGrey[500],
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        getSections(
                                                    touchedIndex,
                                                    getNewList(
                                                        providedTransactions
                                                            .transactions,
                                                        providedTransactions
                                                            .emptyList,
                                                        widget.monthString))![
                                                touchedIndex]
                                            .value
                                            .round()
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.green.withOpacity(0.75),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text('%',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.green.withOpacity(0.75),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),

                              // Icon(
                              //   getIcon(getNewList(providedTransactions.transactions,
                              //           providedTransactions.emptyList)[touchedIndex]
                              //       .category),
                              //   size: 40,
                              // )
                            ],
                          ),
                        ),
                      )
                    : Text(""))
          ]),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          height: 110,
          width: mediaQuery.size.width - 40,
          child: Container(
              decoration: new BoxDecoration(
                  color: (touchedIndex != -1)
                      ? getSections(
                              touchedIndex,
                              getNewList(
                                  providedTransactions.transactions,
                                  providedTransactions.emptyList,
                                  widget.monthString))![touchedIndex]
                          .color
                          .withOpacity(0.25)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 3,
                      blurRadius: 7,
                      // changes position of shadow
                    )
                  ]),
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[500],
                            )),
                        SizedBox(
                          width: 150,
                        ),
                        Text(
                            touchedIndex != -1
                                ? '\$${Transactions().getTotalInCategory(getSections(touchedIndex, getNewList(providedTransactions.transactions, providedTransactions.emptyList, widget.monthString))![touchedIndex].title, getNewList(providedTransactions.transactions, providedTransactions.emptyList, widget.monthString)).toStringAsFixed(1)}'
                                : '\$${Transactions().getTotal(getNewList(providedTransactions.transactions, providedTransactions.emptyList, widget.monthString)).toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.blueGrey[500],
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Number of Transactions:',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey[500],
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                          touchedIndex != -1
                              ? getNoOfTransactionsInCategory(
                                      getSections(
                                                  touchedIndex,
                                                  getNewList(
                                                      providedTransactions
                                                          .transactions,
                                                      providedTransactions
                                                          .emptyList,
                                                      widget.monthString))![
                                              touchedIndex]
                                          .title,
                                      getNewList(
                                          providedTransactions.transactions,
                                          providedTransactions.emptyList,
                                          widget.monthString))
                                  .toString()
                              : getNewList(
                                      providedTransactions.transactions,
                                      providedTransactions.emptyList,
                                      widget.monthString)
                                  .length
                                  .toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[500],
                          ))
                    ],
                  ),
                ),

                // Row(
                //   children: [
                //     Text('astMonth:',
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.blueGrey[500],
                //         )),
                // SizedBox(
                //   width: 50,
                // ),
                // touchedIndex != -1
                //     ? (differenceFromLastMonthInCategory >= 0)
                //         ? Text(
                //             differenceFromLastMonthInCategory
                //                 .toStringAsFixed(1),
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.green,
                //             ))
                //         : Text(
                //             differenceFromLastMonthInCategory
                //                 .toStringAsFixed(1),
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.red,
                //             ))
                //     : (differenceFromLastMonth >= 0)
                //         ? Text(
                //             differenceFromLastMonthInCategory
                //                 .toStringAsFixed(1),
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.green,
                //             ))
                //         : Text(
                //             differenceFromLastMonthInCategory
                //                 .toStringAsFixed(1),
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.red,
                //             ))
                // ],
                // ),
              ])),
        ),
      ],
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
