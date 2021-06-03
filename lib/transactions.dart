import 'package:flutter/material.dart';
import 'pieChartSectionsData.dart';

class Transaction {
  final int id;
  final String name;
  final double value;
  final String category;
  final IconData iconData;
  final Color color;

  const Transaction({
    required this.id,
    required this.name,
    required this.value,
    required this.category,
    required this.iconData,
    required this.color,
  });
}

class Transactions with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(
      id: 1,
      name: 'Metro Groceries',
      value: 128.67,
      category: 'Groceries',
      iconData: Icons.local_grocery_store,
      color: Color(0xfffe91ca),
    ),
    Transaction(
      id: 2,
      name: 'Dinner',
      value: 49.99,
      category: 'Meals',
      iconData: Icons.fastfood,
      color: Color(0xffe8505b),
    ),
    Transaction(
      id: 3,
      name: 'PC game',
      value: 27.35,
      category: 'Gaming',
      iconData: Icons.videogame_asset,
      color: Color(0xfff6d743),
    ),
    Transaction(
      id: 4,
      name: 'Poker',
      value: 34.99,
      category: 'Entertainment',
      iconData: Icons.casino,
      color: Colors.indigo,
    ),
    Transaction(
      id: 5,
      name: 'Shopify',
      value: 113.99,
      category: 'Business',
      iconData: Icons.work,
      color: Color(0xff40bad5),
    ),
    Transaction(
      id: 6,
      name: 'Pizza Pizza',
      value: 25.35,
      category: 'Meals',
      iconData: Icons.fastfood,
      color: Color(0xffe8505b),
    )
  ];
  List<SectionData> sectionData = [];
  String getCategoryInSection(int i) {
    List<String> categories = [
      'Groceries',
      'Business',
      'Entertainment',
      'Meals',
      'Gaming'
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
    ];
    return colors[i];
  }

  double getPercent(String category) {
    double total = 0;
    double valueOfCategory = 0;
    for (int i = 0; i < transactions.length; i++) {
      if (category == transactions[i].category) {
        valueOfCategory = valueOfCategory + transactions[i].value;
      }
      total = total + transactions[i].value;
    }
    return (valueOfCategory / total) * 100;
  }

  List<SectionData> createSectionDataList() {
    List<SectionData> sectionData = [];
    for (int i = 0; i <= 4; i++) {
      String category = getCategoryInSection(i);
      double percent = getPercent(category);
      Color colors = getColor(i);
      if (percent != 0) {
        sectionData.add(SectionData(category, percent, colors));
        // sectionData = List<SectionData>.generate(
        //     1, (i) => SectionData(category, percent, colors));

        // sectionData.add(SectionData(category, percent, colors));
      } else {
        print("fail");
      }
    }
    return sectionData;
  }
}
