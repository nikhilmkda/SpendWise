import 'package:flutter_application_personal_expense_app/controller/change%20theme/dark_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data_provider.dart';

import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'controller/change theme/light_theme.dart';
import 'data/theme_save_hive.dart';
import 'controller/date_picker/date_pick_provider.dart';
import 'controller/notification_provider.dart';
import 'controller/tab_provider.dart';
import 'controller/change theme/theme_provider.dart';
import 'controller/user_provider/user_provider.dart';
import 'package:timezone/data/latest.dart' as tzdata;


void main() async {
  //initialize hive
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 tzdata.initializeTimeZones();
  NotificationProvider().initializeNotifications();
  await _requestNotificationPermission();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  //open a hive box
  await Hive.openBox('themeBox');
  await Hive.openBox('expense_database');
  await Hive.openBox('userProfileBox');

  //Load the selected theme mode from the themeBox using ThemeStorage class
  final themeStorage = ThemeStorage();
  final ThemeMode initialThemeMode = await themeStorage.loadThemeMode();

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(initialThemeMode),
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

//request user to get notification permisssion
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
        themeMode: Provider.of<ThemeProvider>(context).currentThemeMode,
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
                        onPressed: () {
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
                      tabProvider.changeTabIndex(index);

                      // Call handleSearchEnd when the tab changes
                      context.read<ExpenseData>().handleSearchEnd();
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
