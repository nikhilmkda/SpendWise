import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/datetime/date_time_helper.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../bar_graph/my_bargraph.dart';

class MonthlyExpenseSummary extends StatelessWidget {
  final DateTime startOfMonth;

  const MonthlyExpenseSummary({Key? key, required this.startOfMonth})
      : super(key: key);

  double calculateMaxMonth(
    ExpenseData value,
    String jan,
    String feb,
    String mar,
    String apr,
    String may,
    String jun,
    String jul,
    String aug,
    String sep,
    String oct,
    String nov,
    String dec,
  ) {
    double max = 100;

    List<double> values = [
      value.calculateMonthlyExpenseSummary()[jan] ?? 0,
      value.calculateMonthlyExpenseSummary()[feb] ?? 0,
      value.calculateMonthlyExpenseSummary()[mar] ?? 0,
      value.calculateMonthlyExpenseSummary()[apr] ?? 0,
      value.calculateMonthlyExpenseSummary()[may] ?? 0,
      value.calculateMonthlyExpenseSummary()[jun] ?? 0,
      value.calculateMonthlyExpenseSummary()[jul] ?? 0,
      value.calculateMonthlyExpenseSummary()[aug] ?? 0,
      value.calculateMonthlyExpenseSummary()[sep] ?? 0,
      value.calculateMonthlyExpenseSummary()[oct] ?? 0,
      value.calculateMonthlyExpenseSummary()[nov] ?? 0,
      value.calculateMonthlyExpenseSummary()[dec] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  double calculateTotal(ExpenseData value) {
    double total = 0;
    Map<String, double> monthlySummary = value.calculateMonthlyExpenseSummary();
    monthlySummary.forEach((month, amount) {
      total += amount;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    String jan = convertDateTimeToString(DateTime(startOfMonth.year, 1));
    String feb = convertDateTimeToString(DateTime(startOfMonth.year, 2));
    String mar = convertDateTimeToString(DateTime(startOfMonth.year, 3));
    String apr = convertDateTimeToString(DateTime(startOfMonth.year, 4));
    String may = convertDateTimeToString(DateTime(startOfMonth.year, 5));
    String jun = convertDateTimeToString(DateTime(startOfMonth.year, 6));
    String jul = convertDateTimeToString(DateTime(startOfMonth.year, 7));
    String aug = convertDateTimeToString(DateTime(startOfMonth.year, 8));
    String sep = convertDateTimeToString(DateTime(startOfMonth.year, 9));
    String oct = convertDateTimeToString(DateTime(startOfMonth.year, 10));
    String nov = convertDateTimeToString(DateTime(startOfMonth.year, 11));
    String dec = convertDateTimeToString(DateTime(startOfMonth.year, 12));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 10),
          // Monthly total
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Column(
              children: [
                Text(
                  "Monthly Total",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  '\$${calculateTotal(value).toStringAsFixed(2)}',
                  style: GoogleFonts.lato(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Bar graph
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 18),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Monthly Analytics:",
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 140,
                      child: MyBarGraphMonthly(
                        maxY: 100,
                        janAmount:
                            value.calculateMonthlyExpenseSummary()[jan] ?? 0,
                        febAmount:
                            value.calculateMonthlyExpenseSummary()[feb] ?? 0,
                        marAmount:
                            value.calculateMonthlyExpenseSummary()[mar] ?? 0,
                        aprAmount:
                            value.calculateMonthlyExpenseSummary()[apr] ?? 0,
                        mayAmount:
                            value.calculateMonthlyExpenseSummary()[may] ?? 0,
                        junAmount:
                            value.calculateMonthlyExpenseSummary()[jun] ?? 0,
                        julAmount:
                            value.calculateMonthlyExpenseSummary()[jul] ?? 0,
                        augAmount:
                            value.calculateMonthlyExpenseSummary()[aug] ?? 0,
                        sepAmount:
                            value.calculateMonthlyExpenseSummary()[sep] ?? 0,
                        octAmount:
                            value.calculateMonthlyExpenseSummary()[oct] ?? 0,
                        novAmount:
                            value.calculateMonthlyExpenseSummary()[nov] ?? 0,
                        decAmount:
                            value.calculateMonthlyExpenseSummary()[dec] ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
