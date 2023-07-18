import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';
import 'package:flutter_application_personal_expense_app/controller/components/expense.dart';

import 'weekly_expense_summary.dart';

class WeeklyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Consumer<ExpenseData>(
        builder: (context, expenseData, _) {
          // Calculate weekly expense summaries
          Map<String, double> weeklyExpenses =
              expenseData.calculateWeeklyExpenseSummary();

          // Reverse the order of the weeklyExpenses map
          List<String> weeks = weeklyExpenses.keys.toList().reversed.toList();

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ExpenseSummary(startOfWeek: expenseData.startOfWeekDate()),
              Expanded(
                child: ListView.builder(
                  itemCount: weeklyExpenses.length,
                  itemBuilder: (context, index) {
                    String week = weeks[index];
                    double totalExpense = weeklyExpenses[week] ?? 0.0;

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white30],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
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
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          '\$$totalExpense',
                          style: GoogleFonts.lato(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
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
