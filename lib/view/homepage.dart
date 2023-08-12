import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/weekly/weekly_expense_summary.dart';
import 'package:flutter_application_personal_expense_app/view/expense_tile.dart';
import 'package:flutter_application_personal_expense_app/controller/components/expense.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/change theme/theme_provider.dart';
import '../controller/date_picker/date_pick_provider.dart';
import '../controller/merge_sort.dart';
import '../controller/notification_provider.dart';
import '../controller/user_provider/user_provider.dart';

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
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    // final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
    // final currentThemeMode = currentTheme.currentThemeMode;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Expense',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => dateProvider.showDatePickerDialog(context),
            child: Text(
              'Select Date',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.green, // Change the background color to green
              padding: EdgeInsets.symmetric(
                  horizontal: 50, vertical: 12), // Increase the button size
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)), // Round the corners
              elevation: 5, // Add a shadow
            ),
          )
        ]),
        actions: [
          //save button

          MaterialButton(
            onPressed: save,
            child: Text(
              'Save',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
  //delete

  void delete(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void editExpense(ExpenseItem expense, Function() addNewExpense) {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    // final currentTheme = Provider.of<ThemeProvider>(context, listen: false);
    // final currentThemeMode = currentTheme.currentThemeMode;

    newExpenseNameContorller.text = expense.name;
    newExpenseAmountContorller.text = expense.amount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Expense',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => dateProvider.showDatePickerDialog(context),
              child: Text(
                'Select Date',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Change the background color to green
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 12), // Increase the button size
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12)), // Round the corners
                elevation: 5, // Add a shadow
              ),
            )
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
            child: Text(
              'Save',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void saveEditedExpense(ExpenseItem originalExpense) {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    // Use the current date if dateSelected is false, else use the selectedDate
    final selectedDate =
        dateProvider.dateSelected ? dateProvider.selectedDate : DateTime.now();
    if (newExpenseNameContorller.text.isNotEmpty &&
        newExpenseAmountContorller.text.isNotEmpty) {
      final editedExpense = originalExpense.copyWith(
        name: newExpenseNameContorller.text,
        amount: newExpenseAmountContorller.text,
        dateTime: selectedDate,
      );
      Provider.of<ExpenseData>(context, listen: false)
          .editExpense(originalExpense, () => editedExpense);
      Provider.of<NotificationProvider>(context, listen: false)
          .showNotification(
        title: 'Edited ${newExpenseNameContorller.text} expense\n',
        body:
            '${newExpenseNameContorller.text} =  \$ ${newExpenseAmountContorller.text} ',
      );
      dateProvider.clearDate();
    }
  }

//save
  void save() {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    // Use the current date if dateSelected is false, else use the selectedDate
    final selectedDate =
        dateProvider.dateSelected ? dateProvider.selectedDate : DateTime.now();

    //only save if all fields are filled
    if (newExpenseNameContorller.text.isNotEmpty &&
        newExpenseAmountContorller.text.isNotEmpty) {
      //create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameContorller.text,
        amount: newExpenseAmountContorller.text,
        dateTime: selectedDate, //DateTime.now(),
        id: '',
      );

      Provider.of<NotificationProvider>(context, listen: false)
          .showNotification(
        title: 'Added New expense ${newExpenseNameContorller.text}\n',
        body:
            '${newExpenseNameContorller.text} =  \$ ${newExpenseAmountContorller.text} ',
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      // Clear the selectedDate in the DateProvider after saving the new expense
      dateProvider.clearDate();
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
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    // final currentTheme = Provider.of<ThemeProvider>(context);
    // final currentThemeMode = currentTheme.currentThemeMode;
    userDetailsProvider.loadUserProfile();
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  onPressed: addNewExpense,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: ListView(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ' Hey ${userDetailsProvider.nameController.text}',
                          style: Theme.of(context).textTheme.displayLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.primary,
                              size: 35,
                            ),
                            onPressed: () {
                              // Add your search button functionality here
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Theme.of(context).colorScheme.primary,
                              size: 35,
                            ),
                            onPressed: () {
                              // Add your bell button functionality here
                            },
                          ),
                        ],
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllexpenselist().length,
                  itemBuilder: (context, index) {
                    // Sort the expenses list based on the dateTime property using Merge Sort
                    final sortedExpenses = mergeSort(value.getAllexpenselist());

                    final expense = sortedExpenses[index];

                    return ExpenseTile(
                      name: expense.name,
                      amount: expense.amount,
                      dateTime: expense.dateTime,
                      deleteTapped: (p0) => delete(expense),
                      editTapped: (p0) => editExpense(expense, addNewExpense),
                    );
                  },
                )
              ],
            )));
  }
}
