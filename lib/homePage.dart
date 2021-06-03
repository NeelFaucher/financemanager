import 'package:flutter/material.dart';
import 'header.dart';
import 'bottomNavigationBar.dart';
import 'transactionCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  void _onTapped(int index) {
    int _index = 0;
    switch (_index) {
      case 0:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TransactionCard()));
        }
        break;
      default:
        print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.short_text),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text(
          "Expenses Manager",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'sans-serif',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(children: <Widget>[
            Header(),
          ]),
          TransactionCard(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(
        color: Colors.grey,
        backgroundColor: Colors.white,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _onTapped,
        items: [
          BottomNavigatorItem(iconData: Icons.analytics),
          BottomNavigatorItem(iconData: Icons.list),
        ],
      ),

      //
    );
  }
}
