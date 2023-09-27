import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/weekly/weekly_expense_summary.dart';
import 'package:flutter_application_personal_expense_app/view/expense_tile.dart';
import 'package:flutter_application_personal_expense_app/controller/components/expense.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  // Declare text controllers for new expense inputs
  final newExpenseNameContorller = TextEditingController();
  final newExpenseAmountContorller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseData>(context, listen: false).prepareData();
      Provider.of<UserDetailsProvider>(context, listen: false)
          .loadUserProfile();
    });
  }

  // Function to show the new expense dialog
  void addNewExpense() {
    // Get the DatePickProvider instance
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    // Close the search bar if open and dispose of the controller
    Provider.of<ExpenseData>(context, listen: false).handleSearchEnd();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Dialog title
        title: Text(
          'Add New Expense',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        // Dialog content
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          // Expense name input
          TextField(
            controller: newExpenseNameContorller,
            decoration: const InputDecoration(hintText: "Expense Name"),
            keyboardType: TextInputType.name,
          ),
          // Expense amount input
          TextField(
            controller: newExpenseAmountContorller,
            decoration: const InputDecoration(hintText: "Expense Amount"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          // Select date button
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
            // Button styling
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
            ),
          )
        ]),
        actions: [
          // Save button
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
          // Cancel button
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

  // Function to delete an expense
  void delete(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // Function to show the edit expense dialog
  void editExpense(ExpenseItem expense, Function() addNewExpense) {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    newExpenseNameContorller.text = expense.name;
    newExpenseAmountContorller.text = expense.amount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Dialog title
        title: Text(
          'Edit Expense',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        // Dialog content
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense name input
            TextField(
              controller: newExpenseNameContorller,
              decoration: const InputDecoration(hintText: "Expense Name"),
              keyboardType: TextInputType.name,
            ),
            // Expense amount input
            TextField(
              controller: newExpenseAmountContorller,
              decoration: const InputDecoration(hintText: "Expense Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // Select date button
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
              // Button styling
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
              ),
            )
          ],
        ),
        actions: [
          // Save button
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
          // Cancel button
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

  // Function to save edited expense
  void saveEditedExpense(ExpenseItem originalExpense) {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
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
            '${newExpenseNameContorller.text} = ₹ ${newExpenseAmountContorller.text} ',
      );
      dateProvider.clearDate();
    }
  }

  // Function to save new expense
  void save() {
    final dateProvider = Provider.of<DatePickProvider>(context, listen: false);
    final selectedDate =
        dateProvider.dateSelected ? dateProvider.selectedDate : DateTime.now();
    if (newExpenseNameContorller.text.isNotEmpty &&
        newExpenseAmountContorller.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameContorller.text,
        amount: newExpenseAmountContorller.text,
        dateTime: selectedDate,
        id: '',
      );
      Provider.of<NotificationProvider>(context, listen: false)
          .showNotification(
        title: 'Added New expense ${newExpenseNameContorller.text}\n',
        body:
            '${newExpenseNameContorller.text} =  ₹ ${newExpenseAmountContorller.text} ',
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      dateProvider.clearDate();
      clear();
    }
  }

  // Function to cancel the dialog
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // Function to clear input fields
  void clear() {
    newExpenseAmountContorller.clear();
    newExpenseNameContorller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    //  userDetailsProvider.loadUserProfile();
    return Consumer<ExpenseData>(builder: (context, value, child) {
      // Listen to changes in the search query
      value.searchController.addListener(() {
        // Update the search query in the ExpenseData class
        value.updateSearchQuery(value.searchController.text);
      });
      final searchResults = value.searchExpenses(value.searchQuery);
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: FloatingActionButton(
                backgroundColor:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
                onPressed: addNewExpense,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView(
              controller: value.scrollController,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: value.isSearching
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: value.searchController,
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                ),
                                onChanged: (query) {
                                  value.searchExpenses(query);
                                },
                              ),
                            )
                          : Text(
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
                            size: 32,
                          ),
                          onPressed: () {
                            if (value.isSearching) {
                              value.handleSearchEnd();
                            } else {
                              value.handleSearchStart();
                            }
                          },
                        ),
                        GestureDetector(
                          onTap: () =>
                              notificationProvider.showNoNewNotificationToast(),
                          child: Icon(
                            Icons.notifications,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Weekly summary widget
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(
                  height: 20,
                ),
                // Show appropriate content based on search and expense list
                if (value.isSearching &&
                    value.searchExpenses(value.searchController.text).isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "No search results found. ",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: 250,
                            width: 250,
                            child: Image.asset('assets/noresult.png')),
                      ],
                    ),
                  )
                else if (!value.isSearching &&
                    value.getAllexpenselist().isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Add your first expense  ",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: 250,
                            width: 250,
                            child: Image.asset('assets/addExpense.png')),
                      ],
                    ),
                  )
                else
                  // Display the list of expenses
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.isSearching
                        ? searchResults.length
                        : value.getAllexpenselist().length,
                    itemBuilder: (context, index) {
                      final sortedExpenses =
                          mergeSort(value.getAllexpenselist());

                      final expense = value.isSearching
                          ? searchResults[index]
                          : sortedExpenses[index];

                      return ExpenseTile(
                        name: expense.name,
                        amount: expense.amount,
                        dateTime: expense.dateTime,
                        deleteTapped: (p0) => delete(expense),
                        editTapped: (p0) => editExpense(expense, addNewExpense),
                      );
                    },
                  ),
              ],
            ),
          ));
    });
  }
}
