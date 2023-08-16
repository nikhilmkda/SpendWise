import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/data/hive_database.dart';
import 'package:flutter_application_personal_expense_app/datetime/date_time_helper.dart';
import 'package:flutter_application_personal_expense_app/controller/components/expense.dart';

import 'merge_sort.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expense

  List<ExpenseItem> overallexpenseList = [];

  List<ExpenseItem> searchExpenses(String query) {
    return mergeSort(getAllexpenselist()).where((expense) {
      return expense.name.toLowerCase().contains(query.toLowerCase()) ||
          expense.amount.toLowerCase().contains(query.toLowerCase()) ||
          expense.dateTime
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();
  }

  bool isSearching = false;

  final TextEditingController searchController = new TextEditingController();

  void handleSearchStart() {
    isSearching = true;
    notifyListeners();
  }

  void handleSearchEnd() {
    isSearching = false;
    searchController.clear();
    
    notifyListeners();
  }

  //get expense list

  List<ExpenseItem> getAllexpenselist() {
    return overallexpenseList;
  }

  final db = HiveDatabase();
  //prepare data to display
  void prepareData() {
    notifyListeners();
    //if there data exists, get it
    if (db.readData().isNotEmpty) {
      overallexpenseList = db.readData();
    }
  }

  //add new expense

  void addNewExpense(ExpenseItem newExpense) {
    final uniqueId = UniqueKey().toString();
    final updatedExpense = newExpense.copyWith(id: uniqueId);
    overallexpenseList.add(updatedExpense);
    db.saveData(overallexpenseList);
    notifyListeners();
  }

  //delete expense
  void deleteExpense(ExpenseItem deleteExpense) {
    notifyListeners();
    overallexpenseList.remove(deleteExpense);
    db.saveData(overallexpenseList);
  }

  // Edit expense
  void editExpense(
      ExpenseItem originalExpense, ExpenseItem Function() editFunction) {
    final index = overallexpenseList.indexOf(originalExpense);

    if (index != -1) {
      final editedExpense = editFunction();
      overallexpenseList[index] = editedExpense;
      db.saveData(overallexpenseList);
      notifyListeners();
    }
  }

  //get week days
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'mon';
      case 2:
        return 'tue';
      case 3:
        return 'wed';
      case 4:
        return 'thu';
      case 5:
        return 'fri';
      case 6:
        return 'sat';
      case 7:
        return 'sun';

      default:
        return '';
    }
  }

  //weekly expense sum calculated
  Map<String, double> calculateWeeklyExpenseSummary() {
    Map<String, double> weeklyExpenseSummary = {};

    for (var expense in overallexpenseList) {
      DateTime startOfWeek = startOfWeekDateTile(expense.dateTime);
      String week =
          '${startOfWeek.year}-${startOfWeek.month}-${startOfWeek.day}';

      if (weeklyExpenseSummary.containsKey(week)) {
        double currentAmount = weeklyExpenseSummary[week]!;
        currentAmount += double.parse(expense.amount);
        weeklyExpenseSummary[week] = currentAmount;
      } else {
        weeklyExpenseSummary[week] = double.parse(expense.amount);
      }
    }

    return weeklyExpenseSummary;
  }

  //get date for start of the week(sunday)
  DateTime startOfWeekDateTile(DateTime dateTime) {
    DateTime startOfWeek =
        dateTime.subtract(Duration(days: dateTime.weekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get today date
    DateTime today = DateTime.now();

    //go backward to find sunday from today

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date(yyyymmdd): amount total for day
    };
    for (var expense in overallexpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

//start of month
  DateTime startOfMonthDate() {
    DateTime today = DateTime.now();

    // Get the first day of the month
    DateTime startOfMonth = DateTime(today.year, today.month, 1);

    return startOfMonth;
  }

  //monthly expense summmary
  Map<String, double> calculateMonthlyExpenseSummary() {
    Map<String, double> monthlyExpenseSummary = {};

    for (var expense in overallexpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      String month = date.substring(0, 6); // Extract year and month (yyyymm)

      if (monthlyExpenseSummary.containsKey(month)) {
        double currentAmount = monthlyExpenseSummary[month]!;
        currentAmount += amount;
        monthlyExpenseSummary[month] = currentAmount;
      } else {
        monthlyExpenseSummary[month] = amount;
      }
    }

    return monthlyExpenseSummary;
  }
}
