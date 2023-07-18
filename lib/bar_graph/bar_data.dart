import 'package:flutter_application_personal_expense_app/bar_graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Individualbar> bardata = [];

  //initialize bar data

  void initializeBardata() {
    bardata = [
      Individualbar(x: 0, y: sunAmount),
      Individualbar(x: 1, y: monAmount),
      Individualbar(x: 2, y: tueAmount),
      Individualbar(x: 3, y: wedAmount),
      Individualbar(x: 4, y: thuAmount),
      Individualbar(x: 5, y: friAmount),
      Individualbar(x: 6, y: satAmount),
    ];
  }
}

class BarDataMonthly {
  final double janAmount;
  final double febAmount;
  final double marAmount;
  final double aprAmount;
  final double mayAmount;
  final double junAmount;
  final double julAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  BarDataMonthly({
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  });

  List<IndividualBar> barDataMonthly = [];

  // Initialize bar data
  void initializeBarDataMonthly() {
    barDataMonthly = [
      IndividualBar(x: 0, y: janAmount),
      IndividualBar(x: 1, y: febAmount),
      IndividualBar(x: 2, y: marAmount),
      IndividualBar(x: 3, y: aprAmount),
      IndividualBar(x: 4, y: mayAmount),
      IndividualBar(x: 5, y: junAmount),
      IndividualBar(x: 6, y: julAmount),
      IndividualBar(x: 7, y: augAmount),
      IndividualBar(x: 8, y: sepAmount),
      IndividualBar(x: 9, y: octAmount),
      IndividualBar(x: 10, y: novAmount),
      IndividualBar(x: 11, y: decAmount),
    ];
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}
