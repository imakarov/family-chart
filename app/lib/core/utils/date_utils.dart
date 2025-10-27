/// Date and week calculation utilities
class DateUtils {
  /// Get ISO 8601 week number (1-53)
  /// Week starts on Monday, first week contains the first Thursday
  static int getWeekNumber(DateTime date) {
    // Normalize to midnight
    final normalizedDate = DateTime(date.year, date.month, date.day);

    // Find Thursday of this week (current week's Thursday determines the week number)
    final dayOfWeek = normalizedDate.weekday;
    final nearestThursday = normalizedDate.add(Duration(days: 4 - dayOfWeek));

    // Find first Thursday of year
    final firstDayOfYear = DateTime(nearestThursday.year, 1, 1);
    final firstThursdayDayOfWeek = firstDayOfYear.weekday;
    final firstThursday = firstDayOfYear.add(
      Duration(days: (4 - firstThursdayDayOfWeek + 7) % 7),
    );

    // Calculate week number
    final weekNumber = ((nearestThursday.difference(firstThursday).inDays) / 7).floor() + 1;

    return weekNumber;
  }

  /// Get week year (might differ from calendar year for week 1 and week 52/53)
  static int getWeekYear(DateTime date) {
    final weekNumber = getWeekNumber(date);

    // If it's week 1 but still in December, year is next year
    if (weekNumber == 1 && date.month == 12) {
      return date.year + 1;
    }

    // If it's week 52/53 but in January, year is previous year
    if (weekNumber >= 52 && date.month == 1) {
      return date.year - 1;
    }

    return date.year;
  }

  /// Get start date (Monday) of a given week
  static DateTime getWeekStartDate(int weekNumber, int weekYear) {
    // Find first Thursday of the year
    final firstDayOfYear = DateTime(weekYear, 1, 1);
    final firstThursdayDayOfWeek = firstDayOfYear.weekday;
    final firstThursday = firstDayOfYear.add(
      Duration(days: (4 - firstThursdayDayOfWeek + 7) % 7),
    );

    // Calculate the Thursday of target week
    final targetThursday = firstThursday.add(Duration(days: (weekNumber - 1) * 7));

    // Get Monday of that week (Thursday - 3 days)
    final monday = targetThursday.subtract(const Duration(days: 3));

    return DateTime(monday.year, monday.month, monday.day);
  }

  /// Get end date (Sunday) of a given week
  static DateTime getWeekEndDate(int weekNumber, int weekYear) {
    final monday = getWeekStartDate(weekNumber, weekYear);
    return monday.add(const Duration(days: 6));
  }

  /// Convert day name to ISO day number (1=Mon, 7=Sun)
  static int dayNameToNumber(String dayName) {
    const dayMap = {
      'Пн': 1, 'Mon': 1, 'Monday': 1,
      'Вт': 2, 'Tue': 2, 'Tuesday': 2,
      'Ср': 3, 'Wed': 3, 'Wednesday': 3,
      'Чт': 4, 'Thu': 4, 'Thursday': 4,
      'Пт': 5, 'Fri': 5, 'Friday': 5,
      'Сб': 6, 'Sat': 6, 'Saturday': 6,
      'Вс': 7, 'Sun': 7, 'Sunday': 7,
    };
    return dayMap[dayName] ?? 1;
  }

  /// Format frequency string from day names array
  /// Example: ["Пн", "Ср", "Пт"] => "1,3,5"
  static String formatFrequency(List<String> dayNames) {
    return dayNames.map((name) => dayNameToNumber(name).toString()).join(',');
  }
}
