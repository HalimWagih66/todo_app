import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateUtils{
  static String formTaskDateDate(DateTime? dateTime){
    var dateFormat = DateFormat("yyyy MM dd");
    return dateFormat.format(dateTime!);
  }
  static String formTaskDateTime(DateTime? dateTime){
    var dateFormat = DateFormat("mm hh");
    return dateFormat.format(dateTime!);
  }
  static String formTaskAMPM(DateTime? dateTime){
    var dateFormat = DateFormat("a");
    return dateFormat.format(dateTime!);
  }
  static DateTime dateOnly(DateTime input){
    return DateTime(
        input.year,
        input.month,
        input.day
    );
  }
}