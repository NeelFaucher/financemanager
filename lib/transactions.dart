import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pieChart/pieChartSectionsData.dart';
import 'package:intl/intl.dart';

class Transaction {
  //class for a transaction object
  // final int id;
  final String name;
  final double value;
  final String category;
  // final IconData iconData;
  // final Color color;
  final DateTime date;

  const Transaction({
    // required this.id,
    required this.name,
    required this.value,
    required this.category,
    // required this.iconData,
    // required this.color,
    required this.date,
  });
}

class Transactions extends ChangeNotifier {
  //class for the list of transaction objects
  List<Transaction> transactions = [
    Transaction(
      // id: 1,
      name: 'Metro Groceries',
      value: 128.67,
      category: 'Groceries',
      // iconData: Icons.local_grocery_store,
      // color: Color(0xfffe91ca),
      date: DateTime.now().subtract(Duration(days: 7)),
      // DateTime.parse('20210610'),
    ),
    Transaction(
      // id: 2,
      name: 'Dinner',
      value: 49.99,
      category: 'Meals',
      // iconData: Icons.fastfood,
      // color: Color(0xffe8505b),
      date: DateTime.now().subtract(Duration(days: 6)),
      // DateTime.parse('20210710'),
    ),
    Transaction(
      // id: 3,
      name: 'PC game',
      value: 27.35,
      category: 'Gaming',
      // iconData: Icons.videogame_asset,
      // color: Color(0xfff6d743),
      date: DateTime.now().subtract(Duration(days: 7)),
      // DateTime.parse('20210712'),
    ),
    Transaction(
      // id: 4,
      name: 'Poker',
      value: 34.99,
      category: 'Entertainment',
      // iconData: Icons.casino,
      // color: Colors.indigo,
      date: DateTime.now().subtract(Duration(days: 5)),
      // DateTime.parse('20210713'),
    ),
    Transaction(
      // id: 5,
      name: 'Shopify',
      value: 113.99,
      category: 'Business',
      // iconData: Icons.work,
      // color: Color(0xff40bad5),
      date: DateTime.now().subtract(Duration(days: 50)),
      // DateTime.parse('20210614'),
    ),
    Transaction(
      // id: 6,
      name: 'Pizza Pizza',
      value: 25.35,
      category: 'Meals',
      // iconData: Icons.fastfood,
      // color: Color(0xffe8505b),
      date: DateTime.now().subtract(Duration(days: 1)),
      // DateTime.parse('20210616'),
    )
  ];
  List<Transaction> emptyList = [
    Transaction(
      // id: 6,
      name: 'No Expenses',
      value: 0,
      category: 'Empty',
      date: DateTime.now().subtract(Duration(days: 10000)),
      // DateTime.parse('20210616'),
    ),
  ];

  void addData(Transaction data) {
    transactions.add(data);
    notifyListeners();
  }

  //eveything below this point is to get data for the piechart
  List<SectionData> sectionData = [];
  String getCategoryInSection(int i) {
    List<String> categories = [
      'Groceries',
      'Business',
      'Entertainment',
      'Meals',
      'Gaming',
      'Empty'
    ];
    return categories[i];
  }

  Color getColor(int i) {
    List<Color> colors = [
      Color(0xfffe91ca),
      Color(0xff40bad5),
      Colors.indigo,
      Color(0xffe8505b),
      Color(0xfff6d743),
      Colors.grey.withOpacity(0.1)
    ];
    return colors[i];
  }

  double getPercent(String category, List list) {
    double total = 0;
    double valueOfCategory = 0;
    for (int i = 0; i < list.length; i++) {
      if (category == list[i].category && list[i].category != 'Empty') {
        valueOfCategory = valueOfCategory + list[i].value;
      }
      total = total + list[i].value;
    }
    if (total == 0) {
      total = 1;
      if (category == 'Empty') {
        valueOfCategory = 1;
      } else {
        valueOfCategory = 0;
      }
    }
    return (valueOfCategory / total) * 100;
  }

  double getTotalInCategory(String category, List list) {
    double valueOfCategory = 0;
    for (int i = 0; i < list.length; i++) {
      if (category == list[i].category) {
        valueOfCategory = valueOfCategory + list[i].value;
      }
    }
    return valueOfCategory;
  }

  double getTotal(List list) {
    double total = 0;

    for (int i = 0; i < list.length; i++) {
      total = total + list[i].value;
    }
    return total;
  }

  List<SectionData> createSectionDataList(List list) {
    List<SectionData> sectionData = [];
    for (int i = 0; i <= 5; i++) {
      //i is the size of category and colors list

      String category = getCategoryInSection(i);
      double percent = getPercent(category, list);
      double total = getTotalInCategory(category, list);
      Color colors = getColor(i);
      if (percent != 0) {
        sectionData.add(SectionData(category, percent, colors, total));
      }

      // sectionData = List<SectionData>.generate(
      //     1, (i) => SectionData(category, percent, colors));

      // sectionData.add(SectionData(category, percent, colors));
      // } else {
      //   print("fail");
      // }
    }
    return sectionData;
  }
}
