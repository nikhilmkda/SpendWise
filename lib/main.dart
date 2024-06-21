import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_personal_expense_app/controller/change%20theme/dark_theme.dart';
import 'package:flutter_application_personal_expense_app/initial_screen/view/initial_screen.dart';
import 'package:flutter_application_personal_expense_app/sign_in/controller/sign_in_provider.dart';
import 'package:flutter_application_personal_expense_app/sign_in/view/sign_in_screen.dart';
import 'package:flutter_application_personal_expense_app/view/bottom_nav_screen.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();
  NotificationProvider().initializeNotifications();
  await _requestNotificationPermission();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (_) => SignInProvider()),
      ],
      child: MaterialApp(
          title: 'Expense App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: Provider.of<ThemeProvider>(context).currentThemeMode,

          initialRoute: '/',
            routes: {
        '/': (context) => GoogleSignInScreen(),
        '/home': (context) => BottomNavScreen(),
      },
         ),
    );
  }
}
