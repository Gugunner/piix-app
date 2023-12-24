import 'package:intl/intl.dart';

@Deprecated('Will be removed in 4.0')
extension DateExtendDeprecated on DateTime? {
  @Deprecated('Will be removed in 4.0')
  String? get dateFormat {
    if (this == null) return '-';
    return DateFormat('dd/MM/yyyy').format(this!.toLocal());
  }

  @Deprecated('Will be removed in 4.0')
  String? get shortDateFormat {
    if (this == null) return '-';
    return DateFormat('MM/yyyy').format(this!.toLocal());
  }

  @Deprecated('Will be removed in 4.0')
  String? get dateFormatWhithMonth {
    if (this == null) return '-';
    return DateFormat.yMMMMd('es_MX').format(this!.toLocal());
  }

  @Deprecated('Will be removed in 4.0')
  /// Format date from es_US to local time for reading
  String get dateFormatTime {
    if (this != null) {
      final formatter = DateFormat('dd/MM/yyyy');
      final timeFormat = DateFormat('H:mm ');
      final onlyTime = timeFormat.format(this!.toLocal()) + 'h';
      final nowFormatted = formatter.format(this!.toLocal());
      return '$nowFormatted, ${onlyTime.toLowerCase()}';
    } else {
      return '-';
    }
  }
}

extension DateNonNullableExtend on DateTime {
  ///This function adds a specified number of days to the date the extension is
  /// added.
  DateTime datePlusDays(days) {
    return add(Duration(days: days));
  }
}

int getDifferenceInDaysBetweenDates(
    {required DateTime fromDate, required DateTime? toDate}) {
  final difference = toDate?.difference(fromDate);
  return difference?.inDays ?? 5;
}

int getDifferenceInHoursBetweenDates(
    {required DateTime fromDate, required DateTime? toDate}) {
  final difference = toDate?.difference(fromDate);
  return difference?.inHours ?? 120;
}

String addYearsAndFormat(DateTime? currentDate, [int numberOfYears = 0]) {
  if (currentDate == null) return '';
  const days = 365;
  final daysToAddAsYears = days * numberOfYears;
  return currentDate.add(Duration(days: daysToAddAsYears)).dateFormatTime;
}
