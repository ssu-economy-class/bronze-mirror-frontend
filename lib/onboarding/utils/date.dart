import 'package:intl/intl.dart';

class DateUtils {
  static DateTime fromJsonDateTime(String dateStr) => DateTime.parse(dateStr);
  static String toJsonDateTime(DateTime date) => date.toIso8601String();

  static String toServerDate(String input) {
    if (input.length != 6) return '';
    final now = DateTime.now();
    final currentYear = now.year % 100;
    final century = int.parse(input.substring(0, 2)) > currentYear ? 19 : 20;

    try {
      final date = DateTime.parse(
        '$century${input.substring(0, 2)}-${input.substring(2, 4)}-${input.substring(4, 6)}',
      );
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (_) {
      return '';
    }
  }

  static String getFormattedDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final now = DateTime.now();

      final dateOnly = DateTime(date.year, date.month, date.day);
      final nowOnly = DateTime(now.year, now.month, now.day);

      final difference = nowOnly.difference(dateOnly).inDays;

      if (difference == 0) {
        final differenceInMinutes = now.difference(date).inMinutes;
        if (differenceInMinutes < 60) {
          return '$differenceInMinutes분 전';
        } else {
          final differenceInHours = now.difference(date).inHours;
          return '$differenceInHours시간 전';
        }
      } else if (difference == 1) {
        return '어제 ${DateFormat('HH:mm', 'ko_KR').format(date)}';
      } else if (difference <= 3) {
        return '$difference일 전 ${DateFormat('HH:mm', 'ko_KR').format(date)}';
      } else if (now.year == date.year) {
        return DateFormat('MM/dd HH:mm', 'ko_KR').format(date);
      } else {
        return DateFormat('yyyy/MM/dd HH:mm', 'ko_KR').format(date);
      }
    } catch (e) {
      return '';
    }
  }
}
