import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/theme_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            Container(
              child: ThemeSwitchButton(),
            ),
            ExpansionTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
              collapsedTextColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'About',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "App  made by Nikhil K, for effortlessly tracking and managing your expenses. Whether you're a meticulous budgeter or simply looking to gain better control over your spending, ExpenseTrack empowers you with intuitive features and insightful analysis tools to transform your financial management experience.\n \n",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Key Features:\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Local Data Storage: Your financial data is your business. ExpenseGuard prioritizes your privacy by securely storing your information locally on your device, ensuring that only you have access to your sensitive data.\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Customizable Tracking: Effortlessly monitor your expenses on a daily, weekly, and monthly basis. With just a few taps, gain insights into your spending patterns and make informed financial decisions.\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Swipe to Manage: Simplify expense management by swiping to delete or edit transactions. ExpenseGuard's intuitive swipe gestures make it quick and easy to maintain accurate records.\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Comprehensive Insights: Dive into detailed breakdowns of your spending habits over different time periods. Visualize your expenses through clear charts and graphs, enabling you to identify trends and areas for improvement.\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Smart Search: Easily find specific transactions with the smart search feature. Whether you're looking for a recent expense or an entry from months ago, ExpenseGuard helps you locate it with ease.\n\n",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
