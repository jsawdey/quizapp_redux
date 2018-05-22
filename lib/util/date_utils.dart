import 'package:intl/intl.dart';

class DateUtils {
  static String epochMillisecondsToDate(int dateTime, {String locale = 'en_US'}) {
    var dt = DateTime.fromMillisecondsSinceEpoch(dateTime);
    var dtFormatter = new DateFormat.yMd(locale);
    return dtFormatter.format(dt);
  }
}