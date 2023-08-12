import 'package:flutter/material.dart';

class DatePickProvider with ChangeNotifier {
   DateTime selectedDate = DateTime.now();
   bool dateSelected = false;

  void setDate(DateTime newDate) {
    selectedDate = newDate;
     dateSelected = true;
    notifyListeners();
  }
  void clearDate() {
    selectedDate = DateTime.now();
    dateSelected = false;
    notifyListeners();
  }

    Future<void> showDatePickerDialog(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateSelected ? selectedDate : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setDate(pickedDate);
    }
  }

}
