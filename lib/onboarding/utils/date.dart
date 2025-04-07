import 'package:intl/intl.dart';

class DateUtils{
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
}