import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dates.dart';
import 'package:provider/provider.dart';
import '../pages/transactionCard.dart';

//header for the daily transaction page
class DateHeader extends StatefulWidget {
  final List<DateTime> list;
  DateHeader({required this.list});
  String getDateTime(String stringSelectedDay) {
    int selectedDay = int.parse(stringSelectedDay);
    DateTime pressedDate = list[selectedDay];
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(pressedDate);
  }

  @override
  DateHeaderState createState() => DateHeaderState();
}

class DateHeaderState extends State<DateHeader> {
  DateTime now = DateTime.now();
  int activeDay = DateTime.now().weekday - 1;

  // void dispose() {
  //   dateStreamController.close();
  //   super.dispose();
  // }

  // DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Daily Transactions",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              // alignment: Alignment.bottomRight,
              child: Text(
                  DateFormat.yMMMMd('en_US').format(widget.list[activeDay]),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[500],
                  )),
            ),
          ],
        ),

        SizedBox(
          height: 25,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.list.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeDay = index;
                    print(activeDay);
                    // print(widget.getDateTime(activeDay));
                    dateStreamController.sink.add(activeDay);
                  });

                  // StreamBuilder(
                  //     stream: TransactionCard(dateStreamController.stream).stream,
                  //     builder: (context, snapshot) {
                  //       return TransactionCard(dateStreamController.stream);
                  //     });
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 50) / 7,
                  child: Column(
                    children: [
                      Text(
                        DateFormat(DateFormat.ABBR_WEEKDAY)
                            .format(widget.list[index]),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: activeDay == index
                              ? Colors.blue[300]
                              : Colors.black.withOpacity(0.05),
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //     color: activeDay == index
                          //         ? Colors.blue[300]
                          //         : Colors.black.withOpacity(0.1)),),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat(DateFormat.DAY)
                                .format(widget.list[index]),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: activeDay == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })),
        // SizedBox(
        //   height: 10,
        // ),
      ]),
    );
  }
}
