import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/weekly/weekly_expense_summary.dart';
import 'package:flutter_application_personal_expense_app/view/expense_tile.dart';
import 'package:flutter_application_personal_expense_app/controller/components/expense.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
//text controllers
  final newExpenseNameContorller = TextEditingController();
  final newExpenseAmountContorller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseData>(context, listen: false).prepareData();
    });
  }

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Expense'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          //expense name
          TextField(
            controller: newExpenseNameContorller,
            decoration: const InputDecoration(hintText: "Expense Name"),
            keyboardType: TextInputType.name,
          ),
          //expense amount
          TextField(
            controller: newExpenseAmountContorller,
            decoration: const InputDecoration(hintText: "Expense Amount"),
            keyboardType: TextInputType.number,
          ),
        ]),
        actions: [
          //save button

          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),

          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }
  //delete

  void delete(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // void editExpense(ExpenseItem expense, Function() addNewExpense) {}

  //if error remove from here to save edited expense
  void editExpense(ExpenseItem expense, Function() addNewExpense) {
    newExpenseNameContorller.text = expense.name;
    newExpenseAmountContorller.text = expense.amount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameContorller,
              decoration: const InputDecoration(hintText: "Expense Name"),
              keyboardType: TextInputType.name,
            ),
            // expense amount
            TextField(
              controller: newExpenseAmountContorller,
              decoration: const InputDecoration(hintText: "Expense Amount"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              saveEditedExpense(expense);
              Navigator.pop(context);
              clear();
            },
            child: Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void saveEditedExpense(ExpenseItem originalExpense) {
    if (newExpenseNameContorller.text.isNotEmpty &&
        newExpenseAmountContorller.text.isNotEmpty) {
      final editedExpense = originalExpense.copyWith(
        name: newExpenseNameContorller.text,
        amount: newExpenseAmountContorller.text,
      );
      Provider.of<ExpenseData>(context, listen: false)
          .editExpense(originalExpense, () => editedExpense);
    }
  }

//save
  void save() {
    //only save if all fields are filled
    if (newExpenseNameContorller.text.isNotEmpty &&
        newExpenseAmountContorller.text.isNotEmpty) {
      //create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameContorller.text,
        amount: newExpenseAmountContorller.text,
        dateTime: DateTime.now(),
        id: '',
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountContorller.clear();
    newExpenseNameContorller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.grey.shade300,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black87,
              onPressed: addNewExpense,
              child: const Icon(Icons.add),
            ),
            body: ListView(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey.shade900,
                      size: 35,
                    ),
                    onPressed: () {
                      // Add your search button functionality here
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.grey.shade900,
                      size: 35,
                    ),
                    onPressed: () {
                      // Add your bell button functionality here
                    },
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                //weekly summmery
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(
                  height: 20,
                ),
                //expense list
                ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllexpenselist().length,
                    itemBuilder: (context, index) => ExpenseTile(
                          name: value.getAllexpenselist()[index].name,
                          amount: value.getAllexpenselist()[index].amount,
                          dateTime: value.getAllexpenselist()[index].dateTime,
                          deleteTapped: (p0) =>
                              delete(value.getAllexpenselist()[index]),
                          editTapped: (p0) => editExpense(
                              value.getAllexpenselist()[index], addNewExpense),
                        )),
              ],
            )));
  }
}
