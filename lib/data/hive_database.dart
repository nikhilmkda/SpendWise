import 'package:hive/hive.dart';

import '../controller/components/expense.dart';

class HiveDatabase {
  //reference our box
  final mybox = Hive.box('expense_database');
  

  //write data

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      //convert each expense item to storable types(strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    //finally store in database
    mybox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  //read data

  List<ExpenseItem> readData() {
    //convert saved data in to expense objects

    List savedExpenses = mybox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      //collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create expense item

      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime, id: ''); //if error remove id

      //add expense to overall list of expenses

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
