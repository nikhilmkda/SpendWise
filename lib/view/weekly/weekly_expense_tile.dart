import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';

import '../../datetime/date_time_helper.dart';
import 'weekly_expense_summary.dart';

class WeeklyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ExpenseData>(
        builder: (context, expenseData, _) {
          // Calculate weekly expense summaries
          Map<String, double> weeklyExpenses =
              expenseData.calculateWeeklyExpenseSummary();

          //converts the set of keys  of the 'weeklyExpenses' in a week into a list of strings
          List<String> weeks = weeklyExpenses.keys.toList();
          // sorting of the weeks
          weeks.sort((a, b) {
            DateTime dateA = DateFormat('yyyy-MM-dd').parse(a);
            DateTime dateB = DateFormat('yyyy-MM-dd').parse(b);
            return dateB.compareTo(dateA);
          });

          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              // Weekly graph
              ExpenseSummary(startOfWeek: expenseData.startOfWeekDate()),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weeklyExpenses.length,
                itemBuilder: (context, index) {
                  String week = weeks[index];
                  double totalExpense = weeklyExpenses[week] ?? 0.0;

                  // Convert the week string to DateTime using your helper function
                  DateTime weekDate = convertStringToDateTime(week);

                  // Format the week string for display
                  String formattedWeek =
                      DateFormat('dd - MMM - y').format(weekDate);

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
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
                              'Week of : $formattedWeek',
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
                      ],
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
