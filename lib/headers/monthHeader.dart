import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/statsPage.dart';

//header for the monthly breakdown page
class MonthHeader extends StatefulWidget {
  final List<DateTime> list;
  MonthHeader({required this.list});
  String getDateTime(String stringSelectedDay) {
    int selectedDay = int.parse(stringSelectedDay);
    DateTime pressedDate = list[selectedDay];
    DateFormat formatter = DateFormat('yyyy-MM');
    return formatter.format(pressedDate);
  }

  String getDateTimeForLastMonth(String stringSelectedDay) {
    int selectedDay = int.parse(stringSelectedDay);
    DateTime pressedDate = list[selectedDay - 1];
    DateFormat formatter = DateFormat('yyyy-MM');
    print(formatter.format(pressedDate));
    return formatter.format(pressedDate);
  }

  @override
  MonthHeaderState createState() => MonthHeaderState();
}

class MonthHeaderState extends State<MonthHeader> {
  int activeDay = (DateTime.now().month <= 6)
      ? DateTime.now().month - 1
      : DateTime.now().month - 7;

  DateFormat formatter = DateFormat('MM-yy');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Monthly Breakdown",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                child: Text(
                    DateFormat.yMMMM('en_US').format(widget.list[activeDay]),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[500])),
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
                      monthStreamController.sink.add(activeDay);
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 50) / 6,
                    child: Column(
                      children: [
                        Text(
                          DateFormat(DateFormat.ABBR_MONTH)
                              .format(widget.list[index]),
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            color: activeDay == index
                                ? Colors.blue[300]
                                : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(
                            //     color: activeDay == index
                            //         ? Colors.blue[300]
                            //         : Colors.black.withOpacity(0.1)),),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              formatter.format(widget.list[index]),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: activeDay == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
