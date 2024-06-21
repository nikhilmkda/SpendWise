import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';
import 'package:flutter_application_personal_expense_app/controller/tab_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<TabProvider>(
        builder: (context, tabProvider, _) => Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: Theme.of(context).colorScheme.background.withOpacity(0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GNav(
                //backgroundColor: Colors.black26,
                gap: 3,

                hoverColor: Colors.amber,
                activeColor: Theme.of(context).colorScheme.primary,
                tabBackgroundColor: Theme.of(context).colorScheme.background,

                tabBorderRadius: 40,
                iconSize: 24,
                padding: const EdgeInsets.all(12),
                duration: const Duration(milliseconds: 400),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ExpenseData>().handleSearchEnd();
                      if (tabProvider.currentIndex == 0) {
                        Provider.of<ExpenseData>(context, listen: false)
                            .scrollToTop();
                      }
                    },
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                  GButton(
                    icon: Icons.bar_chart_rounded,
                    text: 'Chart',
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
                selectedIndex: tabProvider.currentIndex,
                onTabChange: (index) {
                  // Call handleSearchEnd when the tab changes

                  tabProvider.changeTabIndex(index);
                },
              ),
            ),
          ),
        ),
      ),
      body: Consumer<TabProvider>(
        builder: (context, tabProvider, _) => tabProvider.getCurrentScreen(),
      ),
    );
  }
}
