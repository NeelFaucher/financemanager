import 'package:flutter/material.dart';
import 'statsPage.dart';

import 'transactionCard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'NavBarKey.dart';
import 'newTransaction.dart';

//homepage changes based on what button is clicked on the bottom navigation bar
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final screen = [TransactionCard(), StatsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.short_text),
      //     onPressed: () {},
      //   ),
      //   centerTitle: true,
      //   title: const Text(
      //     "Expenses Manager",
      //     style: TextStyle(
      //       fontSize: 16,
      //       fontFamily: 'sans-serif',
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.person_outline),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Column(children: <Widget>[
            screen[selectedIndex],
          ]),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 3,
            blurRadius: 7,
          ),
        ]),
        child: CurvedNavigationBar(
          buttonBackgroundColor: Colors.blue[300],
          backgroundColor: Colors.white,
          color: Colors.white,
          index: selectedIndex,
          height: 62,
          key: NavBarKey.getKey(),
          items: [
            Icon(
              Icons.list,
              size: 25,
            ),
            // Icon(
            //   Icons.add,
            //   size: 25,
            // ),
            Icon(Icons.analytics, size: 25),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          animationDuration: const Duration(milliseconds: 400),
          animationCurve: Curves.easeInBack,
        ),
      ),

      // bottomNavigationBar: BottomNavigator(
      //   color: Colors.grey,
      //   backgroundColor: Colors.white,
      //   selectedColor: Colors.red,
      //   notchedShape: CircularNotchedRectangle(),
      //   onTabSelected: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigatorItem(iconData: Icons.analytics),
      //     BottomNavigatorItem(iconData: Icons.list),
      //   ],
      // ),

      //
    );
  }
}
