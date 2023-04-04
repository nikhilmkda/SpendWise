import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/sdsxs.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(244, 238, 235, 249),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text('Expense App')),
        ),
        body: ListView(
          children: [
            Homepage(),
          ],
        ),
      ),
    );
  }
}
