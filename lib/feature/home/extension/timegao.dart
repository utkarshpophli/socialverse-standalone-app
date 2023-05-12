import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String timeAgo() {
    final currentDate = DateTime.now();
    if (currentDate.difference(this).inDays > 1) {
      return DateFormat.yMMMd().format(this);
    }
    return timeago.format(this);
  }
}

extension DayMonthExtension on DateTime {
  String dayMonth() {
    return DateFormat.Md().format(this);
  }
}
