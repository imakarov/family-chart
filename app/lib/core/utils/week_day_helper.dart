/// Helper class for working with week days based on user's week start preference
///
/// This helper handles conversion between ISO 8601 day numbers (1-7, Monday-Sunday)
/// and UI display order which can start from either Monday or Sunday.
///
/// ISO 8601 Standard (always used in database):
/// 1 = Monday, 2 = Tuesday, 3 = Wednesday, 4 = Thursday, 5 = Friday, 6 = Saturday, 7 = Sunday
class WeekDayHelper {
  final String weekStartDay; // 'monday' or 'sunday'

  WeekDayHelper(this.weekStartDay);

  /// Get ordered list of ISO day numbers for UI display
  ///
  /// Monday-first: [1, 2, 3, 4, 5, 6, 7] (Mo, Tu, We, Th, Fr, Sa, Su)
  /// Sunday-first: [7, 1, 2, 3, 4, 5, 6] (Su, Mo, Tu, We, Th, Fr, Sa)
  List<int> get orderedDays {
    if (weekStartDay == 'sunday') {
      return [7, 1, 2, 3, 4, 5, 6]; // Start with Sunday
    } else {
      return [1, 2, 3, 4, 5, 6, 7]; // Start with Monday (default)
    }
  }

  /// Convert ISO day number (1-7) to UI index (0-6)
  ///
  /// Monday-first:
  /// - Monday (1) → index 0
  /// - Sunday (7) → index 6
  ///
  /// Sunday-first:
  /// - Sunday (7) → index 0
  /// - Monday (1) → index 1
  /// - Saturday (6) → index 6
  int getUiIndex(int isoDayOfWeek) {
    return orderedDays.indexOf(isoDayOfWeek);
  }

  /// Convert UI index (0-6) to ISO day number (1-7)
  ///
  /// Monday-first:
  /// - index 0 → Monday (1)
  /// - index 6 → Sunday (7)
  ///
  /// Sunday-first:
  /// - index 0 → Sunday (7)
  /// - index 1 → Monday (1)
  /// - index 6 → Saturday (6)
  int getIsoDay(int uiIndex) {
    if (uiIndex < 0 || uiIndex > 6) {
      throw ArgumentError('UI index must be between 0 and 6, got $uiIndex');
    }
    return orderedDays[uiIndex];
  }

  /// Get short day labels in UI order
  ///
  /// Monday-first: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
  /// Sunday-first: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
  List<String> get shortDayLabels {
    const labels = {
      1: 'Mo',
      2: 'Tu',
      3: 'We',
      4: 'Th',
      5: 'Fr',
      6: 'Sa',
      7: 'Su',
    };
    return orderedDays.map((day) => labels[day]!).toList();
  }

  /// Get short day label for ISO day number
  String getShortLabel(int isoDayOfWeek) {
    const labels = {
      1: 'Mo',
      2: 'Tu',
      3: 'We',
      4: 'Th',
      5: 'Fr',
      6: 'Sa',
      7: 'Su',
    };
    return labels[isoDayOfWeek] ?? 'Mo';
  }

  /// Get full day labels in UI order
  ///
  /// Monday-first: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  /// Sunday-first: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  List<String> get fullDayLabels {
    const labels = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    return orderedDays.map((day) => labels[day]!).toList();
  }

  /// Get full day label for ISO day number
  String getFullLabel(int isoDayOfWeek) {
    const labels = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    return labels[isoDayOfWeek] ?? 'Monday';
  }
}
