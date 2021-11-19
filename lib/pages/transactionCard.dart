import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../transactionItems.dart';
import 'package:intl/intl.dart';
import '../headers/dates.dart';
import '../headers/dateHeader.dart';
import 'dart:async';
import '../transactions.dart' as Transaction;
import '../transactions.dart';
import 'newTransaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//daily transactions page
StreamController<int> dateStreamController = StreamController<int>.broadcast();

class TransactionCard extends StatefulWidget {
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  DateTime now = DateTime.now();

  List <Transaction.Transaction> getDateTimeFormatedTransactionList(List <Transaction.Transaction> list){
      list.forEach((i) => {formatter(i.date)});
      return list;
  }
  Future <void> fetchAndSetList(List <Transaction.Transaction> list) async {
    // final List <Transaction.Transaction> loadedList = [];
    // final List < RestaurantitemList > itemList = [];

    await FirebaseFirestore.instance.collection("transactions").get().then(
            (QuerySnapshot querySnapshot) {
          bool itExists = false;
          Transaction.Transaction transaction;
          querySnapshot.docs.forEach((result) =>
          // transaction = Transaction.Transaction(
          //     name: result.get('name'),
          //     value: result.get('value'),
          //     category: result.get('category'),
          //     date: result.get('date').toDate(),)

              list.add(Transaction.Transaction(
              name: result.get('name'),
              value: result.get('value'),
              category: result.get('category'),
              date: result.get('date').toDate(),
              ))

              // for (int i = 0; i < list.length; i++) {
              // if (list[i].name == transaction.name &&
              // list[i].value == transaction.value &&
              // list[i].category == transaction.category &&
              // formatter(transaction.date) ==
              // formatter(transaction.date)) {
              // itExists = true;
              // }
              // }
          );
        }
    );
  }
  //           }
  //   );
  //
  // }

  // => snapshot.data()((f) => {
        // {

          // if (snapshot.exists) {
          //   print('Document data: ${snapshot.data()}');
          // } else {
          //   print('Document does not exist on the database');
          // }
    // //     itemList = [];
    //         f.data()['name']
    //         f.data['items'].forEach((i) =>
    //     itemList.add(RestaurantitemList(
    //     id: i.id,
    //     title: i.title,
    //     imageUrl i.imageUrl
      // you might need to add all fields here, even if they are null
    // )
    // );
    // loadedList.add(Transaction.Transaction(
    // name: i.data['name'],
    // value: i.data['value'],
    // category: i.data['title'],
    // date: i.data['date'],
    // ))
    // }


  String getDocumentId(String name, double value, DateTime date, String category){
    String valueString = value.toString();
    String dateString = formatter(date);

    return category + name + valueString + dateString;


  }

  int getSnapShotInt(String snapShotString, List<DateTime> week) {
    for (int i = 0; i < week.length; i++) {
      if (formatter(week[i]) ==
          DateHeader(list: week).getDateTime(snapShotString)) {
        return i;
      }
    }
    return 0;
  }

  String formatter(DateTime date) {
    DateFormat string = DateFormat('yyyy-MM-dd');
    return string.format(date);
  }

  String getTotal(List<Transaction.Transaction> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total += list[i].value;
    }
    return total.toStringAsFixed(1);
  }

  double getLargestTotalForChart(List<FlSpot> list) {
    double largestTotal = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].y > largestTotal) {
        largestTotal = list[i].y;
      }
    }
    return largestTotal;
  }

  List<Color> gradientColors = [
    const Color(0xff3f51b5),
    const Color(0xff42a5f5),
    const Color(0xffb3e5fc),
  ];

  void removeList(List list1, List list2, int j) {
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] == list2[j]) {
        list1.removeAt(i);
      }
    }
  }

  List<Transaction.Transaction> getNewList(
      List<Transaction.Transaction> list,
      List<Transaction.Transaction> emptyList,
      List<DateTime> weekList,
      String snapshotString) {
    List<Transaction.Transaction> transactionListWDates = [];
    for (int i = 0; i < list.length; i++) {
      if (formatter(list[i].date) ==
          DateHeader(list: weekList).getDateTime(snapshotString)) {

          transactionListWDates.add(list[i]);

      }
    }
    if (transactionListWDates.isEmpty == true) {
      transactionListWDates = emptyList;
    }
    return transactionListWDates;
  }

  List<FlSpot> getLineChartList(List<DateTime> weekList,
      List<Transaction.Transaction> providerList, List<Transaction.Transaction> providerEmptyList) {
    List<FlSpot> FlSpotList = [];

    double getTotal(String snapshotFromNewList) {
      double total = 0;
      List<Transaction.Transaction> dailyList = getNewList(
          providerList, providerEmptyList, weekList, snapshotFromNewList);
      for (int i = 0; i < dailyList.length; i++) {
        total += dailyList[i].value.round();
      }
      return total;
    }

    FlSpotList.add(FlSpot(0, getTotal('\0')));
    for (int i = 0; i < 7; i++) {
      FlSpotList.add(FlSpot(i.toDouble() + 1, getTotal('$i')));
    }
    FlSpotList.add(FlSpot(8, getTotal('\6')));
    return FlSpotList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndSetList(Provider.of<Transactions>(context, listen: false).transactions);
    print('this is getting updated');
  }


  @override
  Widget build(BuildContext context) {
    final List<DateTime> week = Date().getWeek(now);
    final mediaQuery = MediaQuery.of(context);
    final providedTransactions = Provider.of<Transactions>(context);
    // fetchAndSetList(providedTransactions.transactions);
    // fetchAndSetList(providedTransactions.transactions);
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 3,
              blurRadius: 7,
              // changes position of shadow
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 15),
            child: Column(
              children: [
                Row(children: [
                  SizedBox(
                    child: IconButton(
                      icon: Icon(Icons.chevron_left_outlined),
                      padding: EdgeInsets.only(left: 5, top: 30),
                      onPressed: () {
                        now = now.subtract(Duration(days: 7));
                        List<DateTime> newWeek = Date().getWeek(now);
                        setState(() {
                          DateHeader(list: newWeek);
                        });
                      },
                    ),
                    width: 25,
                  ),
                  DateHeader(list: week),
                  SizedBox(
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 5, top: 30),
                      icon: Icon(Icons.chevron_right_outlined),
                      onPressed: () {
                        now = now.add(Duration(days: 7));
                        List<DateTime> newWeek = Date().getWeek(now);
                        setState(() {
                          DateHeader(
                            list: newWeek,
                          );

                          // print(DateHeaderState().getDateTime());
                        });
                      },
                    ),
                    width: 25,
                  ),
                ]),
              ],
            ),
          ),
        ),

      //   FutureBuilder(
      //     future: Future.wait([fetchAndSetList(providedTransactions.transactions)]),
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      // if(!snapshot.hasData){
      // return Center(
      // child: CircularProgressIndicator(),
      // );
      // } else {
        StreamBuilder(
            stream: dateStreamController.stream,
            initialData: DateTime
                .now()
                .weekday - 1,
            builder: (context, snapshot) {
              //
              //
              print('size of list ${providedTransactions.transactions.length}');
              List<Transaction.Transaction> newList = getNewList(
                  providedTransactions.transactions,
                  providedTransactions.emptyList,
                  week,
                  "${snapshot.data}");
               return Column(
                  children: [
                    Container(
                      height: 210,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 18),
                        child: LineChart(
                          mainData(
                              week,
                              providedTransactions.transactions,
                              providedTransactions.emptyList,
                              getSnapShotInt("${snapshot.data}", week)),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        alignment: Alignment.topCenter,
                        curve: Curves.linear,
                        width: mediaQuery.size.width,
                        height: mediaQuery.size.height * 0.44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 3,
                              blurRadius: 7,
                              // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(top: 20, left: 70),
                                  child: Text('Total:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueGrey[500],
                                      )),
                                ),
                                // SizedBox(
                                //   width: 170,
                                // ),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(top: 20, right: 30),
                                  child: Text('\$${getTotal(newList)}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueGrey[500],
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Expanded(
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  itemCount: newList.length,
                                  itemBuilder: (context, i) {
                                    // providedTransactions.transactions
                                    //     .sort((b, a) => a.date.compareTo(b.date));
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 20,
                                          ),
                                          child: Divider(
                                            indent: 60,
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Dismissible(
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                setState(() {
                                                  removeList(
                                                      providedTransactions
                                                          .transactions,
                                                      newList,
                                                      i);
                                                  print(providedTransactions
                                                      .transactions[i].category);
                                                  // providedTransactions.transactions.removeAt(i);
                                                  print("size of list");
                                                  print(newList.length);
                                                  FirebaseFirestore.instance.collection('transactions').doc(getDocumentId(newList[i].name, newList[i].value, newList[i].date, newList[i].category)).delete().then((_) {
                                                    print('succesfully deleted it');
                                                  });


                                                  // print(i);
                                                  // print(getNewList(
                                                  //         providedTransactions.transactions,
                                                  //         providedTransactions.emptyList,
                                                  //         week,
                                                  //         "${snapshot.data}")[i]
                                                  //     .category);

                                                  // getNewList(
                                                  //         providedTransactions.transactions,
                                                  //         providedTransactions.emptyList,
                                                  //         week,
                                                  //         "${snapshot.data}")
                                                  //     .removeAt(i);
                                                });
                                              },
                                              secondaryBackground: Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: mediaQuery.size.width -
                                                          60),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                color: Colors.red[400],
                                              ),
                                              key: UniqueKey(),
                                              background: Container(),
                                              direction:
                                              DismissDirection.endToStart,
                                              child: TransactionItem(newList[i])
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                );

            })
  //   }
  // }),
      ]),
      floatingActionButton:
      // Container(
      //   alignment: Alignment.bottomRight,
      //   padding: EdgeInsets.only(right: 20, bottom: 10),
        FloatingActionButton(
          backgroundColor: Colors.blue[300],
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewTransaction()));
          },
          child: Icon(Icons.add, size: 30),
          elevation: 2.0,
        ),
      // ),
    );
  }

  LineChartData mainData(
      List<DateTime> weekList,
      List<Transaction.Transaction> providerList,
      List<Transaction.Transaction> providerEmptyList,
      int snapshotInt) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: false,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.black, fontSize: 11),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'M';
              case 2:
                return 'T';
              case 3:
                return 'W';
              case 4:
                return 'T';
              case 5:
                return 'F';
              case 6:
                return 'S';
              case 7:
                return 'S';
            }
            return '';
          },
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: getLargestTotalForChart(
              getLineChartList(weekList, providerList, providerEmptyList)) +
          30,
      // largestTotal == 0 ? 200 : largestTotal + 30,
      lineBarsData: [
        LineChartBarData(
          spots: getLineChartList(weekList, providerList, providerEmptyList),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: FlDotData(
              show: true,
              checkToShowDot: (spot, barData) {
                return spot.x == snapshotInt + 1;
              }),

          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.2)).toList(),
          ),
        ),
      ],
    );
  }
}
