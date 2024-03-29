import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/view/settings.dart';
import '../view/ToggleBtn_bar_chart_summary.dart';
import '../view/homepage.dart';
import '../view/user_profile.dart';

class TabProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeTabIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }

  Widget getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const Homepage();
      case 1:
        return const UserProfilePage(
          email: '',
          name: '',
          phone: '',
        );
      case 2:
        return const BarChartSummary();

      case 3:
        return const Settings();

      default:
        return const Homepage();
    }
  }
}
