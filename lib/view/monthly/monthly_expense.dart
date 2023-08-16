import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../bar_graph/my_bargraph.dart';

class MonthlyExpenseSummary extends StatelessWidget {
  final DateTime startOfMonth;

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyyMM').format(dateTime);
  }

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
    String jan = formatDate(DateTime(startOfMonth.year, 1));
    String feb = formatDate(DateTime(startOfMonth.year, 2));
    String mar = formatDate(DateTime(startOfMonth.year, 3));
    String apr = formatDate(DateTime(startOfMonth.year, 4));
    String may = formatDate(DateTime(startOfMonth.year, 5));
    String jun = formatDate(DateTime(startOfMonth.year, 6));
    String jul = formatDate(DateTime(startOfMonth.year, 7));
    String aug = formatDate(DateTime(startOfMonth.year, 8));
    String sep = formatDate(DateTime(startOfMonth.year, 9));
    String oct = formatDate(DateTime(startOfMonth.year, 10));
    String nov = formatDate(DateTime(startOfMonth.year, 11));
    String dec = formatDate(DateTime(startOfMonth.year, 12));

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        Map<String, double> monthlyExpenses =
            value.calculateMonthlyExpenseSummary();

        return Column(
          children: [
            const SizedBox(height: 10),

            // Monthly total
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                children: [
                  Text(
                    "Year Total",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '₹ ${calculateTotal(value).toStringAsFixed(2)}',
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
                        height: 150,
                        child: MyBarGraphMonthly(
                          maxY: calculateMaxMonth(value, jan, feb, mar, apr,
                              may, jun, jul, aug, sep, oct, nov, dec),
                          janAmount: monthlyExpenses[jan] ?? 0,
                          febAmount: monthlyExpenses[feb] ?? 0,
                          marAmount: monthlyExpenses[mar] ?? 0,
                          aprAmount: monthlyExpenses[apr] ?? 0,
                          mayAmount: monthlyExpenses[may] ?? 0,
                          junAmount: monthlyExpenses[jun] ?? 0,
                          julAmount: monthlyExpenses[jul] ?? 0,
                          augAmount: monthlyExpenses[aug] ?? 0,
                          sepAmount: monthlyExpenses[sep] ?? 0,
                          octAmount: monthlyExpenses[oct] ?? 0,
                          novAmount: monthlyExpenses[nov] ?? 0,
                          decAmount: monthlyExpenses[dec] ?? 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
