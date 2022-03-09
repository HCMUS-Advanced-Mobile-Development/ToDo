import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDeadline(DateTime deadline) {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
        .add_jm()
        .format(deadline);
  }
}