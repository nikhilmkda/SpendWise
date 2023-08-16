import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/weekly/weekly_expense_tile.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';

import 'package:provider/provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';

import 'monthly/monthly_expense_tile.dart';

class BarChartSummary extends StatefulWidget {
  const BarChartSummary({Key? key}) : super(key: key);

  @override
  State<BarChartSummary> createState() => _BarChartSummaryState();
}

class _BarChartSummaryState extends State<BarChartSummary> {
  var _tabTextIndexSelected = 1; // Default selected tab index

  final _listTextTabToggle = ["Weekly", "Monthly"]; // Tab labels

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, expenseData, _) {
        final List<Widget> pages = [
          WeeklyExpensePage(), // Weekly expenses page
          MonthlyExpensePage(), // Monthly expenses page
        ];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: heightInPercent(3, context),
              ),
              SizedBox(
                height: heightInPercent(3, context),
              ),
              SizedBox(
                height: 50, // Set a fixed height for the FlutterToggleTab
                child: FlutterToggleTab(
                  width: 98,
                  borderRadius: 10,
                  height: 50,
                  selectedIndex: _tabTextIndexSelected,
                  unSelectedBackgroundColors: [
                    Colors.white10,
                    Colors.white,
                  ],
                  selectedBackgroundColors: const [
                    Colors.black38,
                    Colors.black87,
                  ],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  labels: _listTextTabToggle, // Tab labels
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIndexSelected = index;
                    });
                  },
                  isScroll: false,
                ),
              ),
              Expanded(
                child: pages[_tabTextIndexSelected], // Display selected page based on tab index
              ),
            ],
          ),
        );
      },
    );
  }
}
