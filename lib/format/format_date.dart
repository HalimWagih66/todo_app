import 'package:intl/intl.dart';

class FormDate{
  static String formTaskDateDate(DateTime? dateTime){
    var dateFormat = DateFormat("yyyy MM dd");
    return dateFormat.format(dateTime!);
  }
  static String formTaskDateTime(DateTime? dateTime){
    var dateFormat = DateFormat("mm hh a");
    return dateFormat.format(dateTime!);
  }
}