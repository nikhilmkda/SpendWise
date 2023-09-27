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
import 'package:flutter_application_personal_expense_app/view/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
class MockMethodChannel extends Mock implements MethodChannel {}

class MockDirectory extends Mock implements Directory {
  @override
  String toString() => '/mock/directory/path'; // Provide a mock directory path
  String getNonNullPath() => '/mock/directory/path'; // Custom method to get non-nullable path
}




void main() {
  late MockMethodChannel mockMethodChannel;

    final String testName = 'John Doe';
  final String testEmail = 'john.doe@example.com';
  final String testPhone = '1234567890';
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
  });


Widget createwidgetundertest(){

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
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.8),
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
          body: UserProfilePage(name: testName, email: testEmail, phone: testPhone, ),
        ),
      )
      );
}


  testWidgets('Check app bar name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      createwidgetundertest()
    );

    // Use the `find.text` method to locate the AppBar's title text.
    final appBarTitle = find.text('User Profile');

    // Expect that the app bar title text is found.
    expect(appBarTitle, findsOneWidget);
  });

 testWidgets('Check user details', (WidgetTester tester) async {
  // Build our app and trigger a frame.
  await tester.pumpWidget(createwidgetundertest());

  // Mock user details


  // Set the user details in the UserDetailsProvider
  final userDetailsProvider =
      Provider.of<UserDetailsProvider>(tester.element(find.byType(UserProfilePage)), listen: false);
  userDetailsProvider.nameController.text = testName;
  userDetailsProvider.emailController.text = testEmail;
  userDetailsProvider.phoneController.text = testPhone;

  // Verify that the user details are displayed in the text fields
  expect(find.text(testName), findsOneWidget);
  expect(find.text(testEmail), findsOneWidget);
  expect(find.text(testPhone), findsOneWidget);
});


  
}
