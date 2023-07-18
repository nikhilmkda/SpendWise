import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/expense_data.dart';
import 'package:flutter_application_personal_expense_app/sdsxs.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'controller/tab_provider.dart';
import 'controller/user_provider/profile_image_provider.dart';
import 'controller/user_provider/user_provider.dart';
import 'view/homepage.dart';

void main() async {
  //initialize hive
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  
  //open a hive box
  await Hive.openBox('expense_database');
  await Hive.openBox('userProfileBox');

  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
      ],
      child: MaterialApp(
        title: 'Expense App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade300,
          bottomNavigationBar: Consumer<TabProvider>(
            builder: (context, tabProvider, _) => Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colors.black87,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GNav(
                    //backgroundColor: Colors.black26,
                    gap: 3,

                    hoverColor: Colors.white,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.white24,
                    tabBorderRadius: 40,
                    iconSize: 24,
                    padding: const EdgeInsets.all(12),
                    duration: const Duration(milliseconds: 400),
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                        iconColor: Colors.white,
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                        iconColor: Colors.white,
                      ),
                      GButton(
                        icon: Icons.bar_chart_rounded,
                        text: 'Chart',
                        iconColor: Colors.white,
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
