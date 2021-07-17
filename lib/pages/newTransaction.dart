import 'package:financemanager2/pieChart/expenseChart.dart';
import 'package:financemanager2/pieChart/pieChartSections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transactions.dart';
import 'package:provider/provider.dart';
import '../pieChart/pieChartSectionsData.dart';
import '../pieChart/expenseChart.dart';
import 'transactionCard.dart';
import 'package:flutter/services.dart';

//add transactions page
class NewTransaction extends StatefulWidget {
  @override
  NewTransactionState createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  String formatter(DateTime date) {
    DateFormat string = DateFormat('yyyy-MM');
    return string.format(date);
  }

  int activeCategory = 0;
  List<String> categories = [
    'Groceries',
    'Business',
    'Entertainment',
    'Meals',
    'Gaming',
  ];
  List<Color> colors = [
    Color(0xfffe91ca),
    Color(0xff40bad5),
    Colors.indigo,
    Color(0xffe8505b),
    Color(0xfff6d743),
  ];
  List<IconData> icons = [
    Icons.local_grocery_store,
    Icons.work,
    Icons.casino,
    Icons.fastfood,
    Icons.videogame_asset,
  ];
  showAlertDialog(BuildContext context, String textForAlertDialog) {
    AlertDialog alert = AlertDialog(
      title: Container(
          margin: EdgeInsets.all(5),
          child: Text(textForAlertDialog,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[500]))),
      actions: [
        FloatingActionButton(
            child: Text("OK"), onPressed: () => Navigator.pop(context))
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Transaction getNewTransaction(String name, String category, double value) {
    return Transaction(
        name: name, value: value, category: category, date: DateTime.now());
  }

  TextEditingController _budgetName = TextEditingController();
  TextEditingController _budgetPrice = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _budgetName.dispose();
    _budgetPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    final providedTransactions =
        Provider.of<Transactions>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 7,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Expenses",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      IconButton(
                        padding: EdgeInsets.only(right: 15, top: 5),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.blueGrey[500]!.withOpacity(0.7),
                        icon: Icon(Icons.close_rounded),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "Choose Category",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[500]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? Colors.lightBlueAccent
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.01),
                            spreadRadius: 5,
                            blurRadius: 5,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[index].withOpacity(0.5)),
                              child: Center(
                                child: Icon(
                                  icons[index],
                                  size: 30,
                                ),
                              )),
                          Text(
                            categories[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expense Name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueGrey[500]),
                ),
                TextField(
                  controller: _budgetName,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[500]),
                  decoration: InputDecoration(
                      hintText: "Ex. Weekly Groceries",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueGrey[500]!.withOpacity(0.5))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cost",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blueGrey[500]),
                          ),
                          TextField(
                            controller: _budgetPrice,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[500]),
                            decoration: InputDecoration(
                                hintText: "Ex. 150",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    color: Colors.blueGrey[500]!
                                        .withOpacity(0.5))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // Consumer<Transactions>(
                    //   builder: (context, Transactions transactions, child) =>
                    FloatingActionButton(
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () {
                        //on this onpressed a new transaction is added- you prob need to add statement here to connect it to the database
                        providedTransactions.addData(getNewTransaction(
                            _budgetName.text,
                            categories[activeCategory],
                            double.parse(_budgetPrice.text)));

                        // print(Transactions()
                        //     .getPercent(newTransactionObject.category)
                        //     .toString());
                        // Transactions().createSectionDataList();
                        setState(() {
                          ExpenseChart(monthString: formatter(DateTime.now()));
                        });
                        print(providedTransactions.transactions.length
                            .toString());
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => TransactionCard()));
                      },
                      elevation: 3.0,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
