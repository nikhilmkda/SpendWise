import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';

import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'controller/notification_provider.dart';
import 'controller/tab_provider.dart';
import 'controller/change theme/theme_provider.dart';
import 'controller/user_provider/profile_image_provider.dart';
import 'controller/user_provider/user_provider.dart';

void main() async {
  //initialize hive
  WidgetsFlutterBinding.ensureInitialized();
  NotificationProvider().initializeNotifications();
  await _requestNotificationPermission(); //remove if error

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  //open a hive box
  await Hive.openBox('expense_database');
  await Hive.openBox('userProfileBox');

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// remove _requestNotificationPermission if error
Future<void> _requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    final currentThemeMode = currentTheme.currentThemeMode;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseData()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Expense App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<ThemeProvider>(context).currentThemeMode,
        home: Scaffold(
          //backgroundColor: Colors.grey.shade300,
          bottomNavigationBar: Consumer<TabProvider>(
            builder: (context, tabProvider, _) => Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: currentThemeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.grey.shade300,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GNav(
                    //backgroundColor: Colors.black26,
                    gap: 3,

                    hoverColor: currentThemeMode == ThemeMode.light
                        ? Colors.amber
                        : Colors.amber,
                    activeColor: currentThemeMode == ThemeMode.light
                        ? Colors.grey.shade300
                        : Colors.black,
                    tabBackgroundColor: currentThemeMode == ThemeMode.light
                        ? Colors.grey.shade700
                        : Colors.black38,
                    tabBorderRadius: 40,
                    iconSize: 24,
                    padding: const EdgeInsets.all(12),
                    duration: const Duration(milliseconds: 400),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                        iconColor: currentThemeMode == ThemeMode.light
                            ? Colors.grey.shade300
                            : Colors.black,
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                        iconColor: currentThemeMode == ThemeMode.light
                            ? Colors.grey.shade300
                            : Colors.black,
                      ),
                      GButton(
                        icon: Icons.bar_chart_rounded,
                        text: 'Chart',
                        iconColor: currentThemeMode == ThemeMode.light
                            ? Colors.grey.shade300
                            : Colors.black,
                      ),
                    ],
                    selectedIndex: tabProvider.currentIndex,
                    onTabChange: (index) {
                      tabProvider.changeTabIndex(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          body: Consumer<TabProvider>(
            builder: (context, tabProvider, _) =>
                tabProvider.getCurrentScreen(),
          ),
        ),
      ),
    );
  }
}
