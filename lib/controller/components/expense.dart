class ExpenseItem {
  String id;
  late final String name;
  late final DateTime dateTime;
  late final String amount;

  ExpenseItem({ required this.id,required this.name,required this.amount,required this.dateTime});

  //if error remove copy with function
  //to edit expense and update it
  ExpenseItem copyWith({     
    String? id,
    String? name,
    String? amount,
    DateTime? dateTime,
  }) {
    return ExpenseItem(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

