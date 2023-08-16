import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';

import 'weekly_expense_summary.dart';

class WeeklyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final currentTheme = Provider.of<ThemeProvider>(context);
    // final currentThemeMode = currentTheme.currentThemeMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ExpenseData>(
        builder: (context, expenseData, _) {
          // Calculate weekly expense summaries
          Map<String, double> weeklyExpenses =
              expenseData.calculateWeeklyExpenseSummary();

          // Reverse the order of the weeklyExpenses map
          List<String> weeks = weeklyExpenses.keys.toList();
          weeks.sort((a, b) => a.compareTo(b));

          return ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              //weekly graph
              ExpenseSummary(startOfWeek: expenseData.startOfWeekDate()),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weeklyExpenses.length,
                itemBuilder: (context, index) {
                  String week = weeks[index];
                  double totalExpense = weeklyExpenses[week] ?? 0.0;

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
                              'Week of : ${week.substring(7)}${week.substring(4, 7)}${week.substring(0, 4)}',
                              style: GoogleFonts.nunito(
                                  fontSize: 17,
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
