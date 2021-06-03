import 'package:flutter/material.dart';
import 'chart/expenseChart.dart';

class Header extends StatelessWidget {
  // static List<charts.Series<Expense, String>> _series = [
  //   charts.Series<Expense, String>(
  //     id: 'Expense',
  //     domainFn: (Expense expense, _) => expense.category,
  //     measureFn: (Expense expense, _) => expense.value,
  //     labelAccessorFn: (Expense expense, _) => '\$${expense.value}',
  //     colorFn: (Expense expense, _) =>
  //         charts.ColorUtil.fromDartColor(expense.color),
  //     // data: [
  //     //   Expense('Business', 149.99, Color(0xff40bad5)),
  //     //   Expense('Meals', 143.99, Color(0xffe8505b)),
  //     //   Expense('Gifts', 49.99, Color(0xfffe91ca)),
  //     //   Expense('Gaming', 27.99, Color(0xfff6d743)),
  //     //   Expense('Entertainment', 34.99, Color(0xfff57b51))
  //     // ],
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height * .4,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: ExpenseChart(),
            ),
            // const SizedBox(height: 14),
            // Row(
            //   children: <Widget>[
            //     OutlinedButton(
            //       onPressed: () {},
            //       style: OutlinedButton.styleFrom(
            //           side: const BorderSide(
            //             width: 1,
            //             color: Colors.white,
            //             //might be wrong
            //           ),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(24.0),
            //           )),
            //       child: Container(
            //         width: 100,
            //         // child: Row(
            //         //   mainAxisAlignment: MainAxisAlignment.center,
            //         //   children: <Widget>[
            //         //     const Icon(Icons.playlist_add, color: Colors.white),
            //         //     const SizedBox(width: 4),
            //         //     const Text(
            //         //       'Add Transaction',
            //         //       style: TextStyle(
            //         //         fontSize: 12,
            //         //         color: Colors.white,
            //         //         fontWeight: FontWeight.bold,
            //         //       ),
            //         //     )
            //         //   ],
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
