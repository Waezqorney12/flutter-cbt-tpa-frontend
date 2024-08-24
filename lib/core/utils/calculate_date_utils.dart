import '../entities/calendar_entities.dart';

class CalendarUtils {
  late final List<CalendarEntities> months;

  CalendarUtils({required DateTime start, required DateTime end}) {
    months = List.generate(
      (end.year - start.year) * 12 + end.month - start.month + 1,
      (index) {
        final month = start.month + index - 1;
        final year = start.year + (month - 1) ~/ 12;
        final monthOfYear = (month - 1) % 12 + 1;
        final daysInMonth = DateTime(year, monthOfYear + 1, 0).day;
        return CalendarEntities(year: year, moth: monthOfYear, days: daysInMonth);
      },
    );
  }

  int daysInMonth(int year, int month) {
    final monthData = months.firstWhere(
      (element) => element.year == year && element.moth == month,
      orElse: () => throw ArgumentError('Invalid year or month'),
    );
    return monthData.days;
  }
}

extension DurationExtension on Duration {
  String getCalendarDiffer({required int month}) {
    if (inDays > 0) {
      final totalMonth = (inDays / month).floor();
      if (totalMonth > 0) {
        return "$totalMonth month ago";
      }
      return "$inDays days ago";
    } else if (inHours > 0) {
      return "$inHours hours ago";
    } else {
      return "$inMinutes minutes ago";
    }
  }
}
