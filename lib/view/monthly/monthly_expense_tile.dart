import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';

import 'monthly_expense.dart';

// Function to convert "yyyymm" string to DateTime
DateTime convertStringToDateTime(String monthString) {
  // Parse the year and month components
  int year = int.parse(monthString.substring(0, 4));
  int month = int.parse(monthString.substring(4));
  return DateTime(year, month);
}

class MonthlyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ExpenseData>(
        builder: (context, expenseData, _) {
          // Calculate monthly expense summaries
          Map<String, double> monthlyExpenses =
              expenseData.calculateMonthlyExpenseSummary();

          List<String> months = monthlyExpenses.keys.toList();

          // Sort the months using the custom convertStringToDateTime function
          months.sort((a, b) =>
              convertStringToDateTime(a).compareTo(convertStringToDateTime(b)));

          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              MonthlyExpenseSummary(
                  startOfMonth: expenseData.startOfMonthDate()),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: monthlyExpenses.length,
                itemBuilder: (context, index) {
                  String month = months[index];
                  double totalExpense = monthlyExpenses[month] ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.background,
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.6)
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                          '${DateFormat('MMMM yyyy').format(convertStringToDateTime(month))}',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        trailing: Text(
                          '₹ $totalExpense',
                          style: GoogleFonts.lato(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
