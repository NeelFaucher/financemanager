import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../pieChart/expenseChart.dart';
import 'package:intl/intl.dart';
import '../headers/dates.dart';
import '../headers/monthHeader.dart';
import 'dart:async';
import '../pieChart/pieChartSections.dart';
import '../transactions.dart';
import 'package:provider/provider.dart';

//monthly breakdown page
StreamController<int> monthStreamController = StreamController<int>.broadcast();

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  double totalPerMonth = 0;
  DateTime now = DateTime.now();
  DateTime lastMonth = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  String formatter(DateTime date) {
    DateFormat string = DateFormat('yyyy-MM-dd');
    return string.format(date);
  }

  int getInitDataForBuilder() {
    now = DateTime.now();
    if (now.month <= 6) {
      return now.month - 1;
    } else
      return now.month - 7;
  }

  @override
  Widget build(BuildContext context) {
    final providedTransactions = Provider.of<Transactions>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final List<DateTime> month = Date().getMonth(now);
    final List<DateTime> prevMonth = Date().getMonth(lastMonth);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 3,
                blurRadius: 7,
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: IconButton(
                          icon: Icon(Icons.chevron_left_outlined),
                          padding: EdgeInsets.only(left: 5, top: 30),
                          onPressed: () {
                            now = DateTime(now.year, now.month - 6, now.day);
                            lastMonth = DateTime(lastMonth.year,
                                lastMonth.month - 6, lastMonth.day);
                            List<DateTime> newMonths = Date().getMonth(now);
                            setState(() {
                              MonthHeader(list: newMonths);
                            });
                          },
                        ),
                        width: 25,
                      ),
                      MonthHeader(list: month),
                      SizedBox(
                        child: IconButton(
                          icon: Icon(Icons.chevron_right_outlined),
                          padding: EdgeInsets.only(right: 5, top: 30),
                          onPressed: () {
                            now = DateTime(now.year, now.month + 6, now.day);
                            lastMonth = DateTime(lastMonth.year,
                                lastMonth.month + 6, lastMonth.day);
                            List<DateTime> newMonths = Date().getMonth(now);
                            setState(() {
                              MonthHeader(list: newMonths);
                            });
                          },
                        ),
                        width: 25,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 500,
                  child: StreamBuilder(
                      stream: monthStreamController.stream,
                      initialData: getInitDataForBuilder(),
                      builder: (context, snapshot) {
                        return ExpenseChart(
                            monthString: MonthHeader(list: month)
                                .getDateTime("${snapshot.data}"));
                      }),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Test {
  late int testVar = -1;
}
