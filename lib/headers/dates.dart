import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//gets data for both the dateheader and monthheader
class Date {
  List<DateTime> getWeek(DateTime date) {
    List<DateTime> weekList = [];
    String dateString = DateFormat(DateFormat.ABBR_WEEKDAY).format(date);
    if (dateString == 'Mon') {
      DateTime nextDays = date;
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else if (dateString == 'Tue') {
      DateTime nextDays = date.subtract(Duration(days: 1));
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else if (dateString == 'Wed') {
      DateTime nextDays = date.subtract(Duration(days: 2));
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else if (dateString == "Thu") {
      DateTime nextDays = date.subtract(Duration(days: 3));
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else if (dateString == "Fri") {
      DateTime nextDays = date.subtract(Duration(days: 4));
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else if (dateString == "Sat") {
      DateTime nextDays = date.subtract(Duration(days: 5));
      for (int i = 0; i < 7; i++) {
        weekList.add(nextDays);
        nextDays = nextDays.add(Duration(days: 1));
      }
      return weekList;
    } else {
      DateTime prevDays = date.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        weekList.add(prevDays);
        prevDays = prevDays.add(Duration(days: 1));
      }
      return weekList;
    }
  }

  List<DateTime> getMonth(DateTime date) {
    List<DateTime> monthList = [];
    String dateString = DateFormat(DateFormat.ABBR_MONTH).format(date);
    if (dateString == 'Jan') {
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Feb') {
      date = new DateTime(date.year, date.month - 1, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Mar') {
      date = new DateTime(date.year, date.month - 2, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Apr') {
      date = new DateTime(date.year, date.month - 3, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'May') {
      date = new DateTime(date.year, date.month - 4, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Jun') {
      date = new DateTime(date.year, date.month - 5, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Jul') {
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Aug') {
      date = new DateTime(date.year, date.month - 1, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Sep') {
      date = new DateTime(date.year, date.month - 2, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Oct') {
      date = new DateTime(date.year, date.month - 3, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Nov') {
      date = new DateTime(date.year, date.month - 4, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else if (dateString == 'Nov') {
      date = new DateTime(date.year, date.month - 4, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    } else {
      date = new DateTime(date.year, date.month - 5, date.day);
      for (int i = 0; i < 6; i++) {
        monthList.add(date);
        date = new DateTime(date.year, date.month + 1, date.day);
      }
      return monthList;
    }
  }
}
