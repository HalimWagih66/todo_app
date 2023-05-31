import 'package:intl/intl.dart';

class FormDate{
  static String formTaskDateDate(DateTime dateTime){
    var dateFormat = DateFormat("yyyy MMM-dd");
    return dateFormat.format(dateTime);
  }
}