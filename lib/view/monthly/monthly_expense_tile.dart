import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';

import '../../controller/change theme/theme_provider.dart';
import 'monthly_expense.dart';

class MonthlyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ExpenseData>(
        builder: (context, expenseData, _) {
          // Calculate weekly expense summaries
          Map<String, double> monthlyExpenses =
              expenseData.calculateMonthlyExpenseSummary();

          List<String> months = monthlyExpenses.keys.toList();
//sort the months according to date
          months.sort((a, b) => a.compareTo(b));

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              MonthlyExpenseSummary(
                  startOfMonth: expenseData.startOfMonthDate()),
              Expanded(
                child: ListView.builder(
                  itemCount: monthlyExpenses.length,
                  itemBuilder: (context, index) {
                    String week = months[index];
                    double totalExpense = monthlyExpenses[week] ?? 0.0;

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
                            'Month   ${months[index].substring(5)}-${months[index].substring(0, 4)}',
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
              ),
            ],
          );
        },
      ),
    );
  }
}
