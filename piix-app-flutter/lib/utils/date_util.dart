String? toIsoString(DateTime? date) => date?.toIso8601String();

DateTime toDateTime(String? date) =>
    date != null ? DateTime.parse(date) : DateTime.now();

int currentYear() => DateTime.now().year;

String age(
  DateTime? dateOfBirth, [
  bool returnYear = true,
  bool returnMonth = false,
  bool returnDay = false,
]) {
  if (dateOfBirth == null) return '-';
  const daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final currentDate = DateTime.now();

  final birthDay = dateOfBirth.day;
  final birthMonth = dateOfBirth.month;
  final birthYear = dateOfBirth.year;
  var currentDay = currentDate.day;
  var currentMonth = currentDate.month;
  var currentYear = currentDate.year;

  if (currentDay < birthDay) {
    currentMonth = currentMonth - 1;
    currentDay = currentDay + daysInMonths[birthMonth - 1];
  }

  if (currentMonth < birthMonth) {
    currentYear = currentYear - 1;
    currentMonth = currentMonth + 12;
  }

  final calculatedDay = currentDay - birthDay;
  final calculatedMonth = currentMonth - birthMonth;
  final calculatedYear = currentYear - birthYear;

  var age = '';
  if (returnYear) age += '$calculatedYear';
  if (returnMonth) age += ',$calculatedMonth';
  if (returnDay) age += ',$calculatedDay';

  return age;
}

///Checks if the passed [date] is after the passed [xTime].
///
///Compares the current date and time to the passed date and time
///if the difference is greater than [xTime] returns true, otherwise
///returns false.0
bool dateAfterXTime({
  required DateTime date,
  Duration xTime = const Duration(hours: 4),
}) =>
    DateTime.now().difference(date) > xTime;
