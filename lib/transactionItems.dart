import 'package:flutter/material.dart';

import 'transactions.dart';

//makes the individual items in list for daily transactions
class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
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

    return Container(
        height: 70,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: getColor(transaction.category).withOpacity(.5),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(getIcon(transaction.category),
                size: 20, color: Colors.white),
          ),
          title: Text(
            transaction.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            transaction.category,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          trailing: Text('\$${transaction.value}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              )),
        ));
  }
}
