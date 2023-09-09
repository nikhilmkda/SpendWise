import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_personal_expense_app/controller/change%20theme/dark_theme.dart';
import 'package:flutter_application_personal_expense_app/controller/change%20theme/light_theme.dart';
import 'package:flutter_application_personal_expense_app/controller/date_picker/date_pick_provider.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';
import 'package:flutter_application_personal_expense_app/controller/notification_provider.dart';
import 'package:flutter_application_personal_expense_app/controller/tab_provider.dart';
import 'package:flutter_application_personal_expense_app/controller/user_provider/user_provider.dart';
import 'package:flutter_application_personal_expense_app/view/homepage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MockMethodChannel extends Mock implements MethodChannel {}
// Define a mock class for ExpenseData provider
class MockExpenseDataProvider extends Mock implements ExpenseData {}

class MockDirectory extends Mock implements Directory {
  @override
  String toString() => '/mock/directory/path'; // Provide a mock directory path
  String getNonNullPath() =>
      '/mock/directory/path'; // Custom method to get non-nullable path
}

void main() {
  late MockMethodChannel mockMethodChannel;
   final mockExpenseDataProvider = MockExpenseDataProvider();

   
  setUpAll(() async {
    // Initialize Hive

    // Create and configure the mock MethodChannel
    mockMethodChannel = MockMethodChannel();
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '/mock/directory/path';
      }
      return null;
    });

    // Use the mock directory for Hive initialization
    final MockDirectory mockDirectory = MockDirectory();
    Hive.init(mockDirectory.getNonNullPath());
    await Hive.openBox('themeBox');
    await Hive.openBox('expense_database');
    await Hive.openBox('userProfileBox');
  });

  Widget createwidgetundertest() {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ExpenseData()),
          ChangeNotifierProvider(create: (_) => TabProvider()),
          ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => DatePickProvider()),
        ],
        child: MaterialApp(
          title: 'Expense App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Scaffold(
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
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GNav(
                      //backgroundColor: Colors.black26,
                      gap: 3,

                      hoverColor: Colors.amber,
                      activeColor: Theme.of(context).colorScheme.primary,
                      tabBackgroundColor:
                          Theme.of(context).colorScheme.background,

                      tabBorderRadius: 40,
                      iconSize: 24,
                      padding: const EdgeInsets.all(12),
                      duration: const Duration(milliseconds: 400),
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                          iconColor: Theme.of(context).colorScheme.primary,
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
                        tabProvider.changeTabIndex(index);

                        // Call handleSearchEnd when the tab changes
                        context.read<ExpenseData>().handleSearchEnd();
                      },
                    ),
                  ),
                ),
              ),
            ),
            body: Homepage(),
          ),
        ));
  }

  testWidgets('Check app bar name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createwidgetundertest());

    expect(find.byType(Homepage), findsOneWidget);
  });

  testWidgets('Test adding a new expense', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createwidgetundertest());

    // Find and tap the "Add" button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    // Verify that the new expense dialog appears.
    expect(find.text('Add New Expense'), findsOneWidget);

    // Fill in the expense details and save.
    await tester.enterText(find.byType(TextField).at(0), 'Expense Name');
    await tester.enterText(find.byType(TextField).at(1), '100');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pump();
  });
}
