//convert date time object to a string yyyymmdd

String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}


//remove if unnecessary, or bug (for expense summary, month and year total)
DateTime convertStringToDateTime(String dateString) {
  // Split the string into year, month, and day components
  List<String> dateComponents = dateString.split('-');
  int year = int.parse(dateComponents[0]);
  int month = int.parse(dateComponents[1]);
  int day = int.parse(dateComponents[2]);

  // Create a DateTime object from the components
  DateTime dateTime = DateTime(year, month, day);

  return dateTime;
}
