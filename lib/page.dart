// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Test extends StatefulWidget {
//   const Test({
//     Key? key,
//     this.sumOut,
//   }) : super(key: key);

//   final double? sumOut;

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   //List<String> newtext = [];

//   final _textController = TextEditingController();

//   Widget valueofSum() {
//     String numberAsString = sum.toString();

//     //var total = 12000 - sum;

//     return Text(
//       numberAsString,
//       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }

//   int sum = 0;

//   List<int> newList = [];
//   List<String> _list = [];
//   @override
//   void initState() {
//     super.initState();
//     _loadListFromPreferences();
//     _loadSum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//       backgroundColor: Color.fromARGB(244, 238, 235, 249),
//       // floatingActionButton: Padding(
//       //   padding: const EdgeInsets.only(top: 250),
//       //   child: FloatingActionButton(
//       //  backgroundColor: Colors.green,
//       //     child: Icon(
//       //       Icons.add,
//       //     ),
//       //     onPressed: () {},
//       //   ),
//       // ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               TextField(
//                 onEditingComplete: () {
//                   setState(() {
//                     if (_textController.text.isNotEmpty) {
//                       _list.add(_textController.text);
//                       _textController.text = "";
//                       _textController.clear();

//                       List<int> newList =
//                           _list.map((string) => int.parse(string)).toList();
//                       sum = newList.fold(0,
//                           (previousValue, element) => previousValue + element);
//                       _saveListToPreferences();
//                       _saveSum();
//                     }
//                   });
//                 },
//                 controller: _textController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 9, 81, 11)),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(0),
//                       )),
//                   hintText: 'Enter Daily Expense',
//                 ),
//               ),
//               Padding(
//                 padding:
//                     EdgeInsets.only(left: 300, top: 4, bottom: 4, right: 8),
//                 child: ElevatedButton(
//                     onPressed: () {
//                       //newtext = userExpense.text;
//                       setState(() {
//                         if (_textController.text.isNotEmpty) {
//                           _list.add(_textController.text);
//                           _textController.text = "";
//                           _textController.clear();

//                           List<int> newList =
//                               _list.map((string) => int.parse(string)).toList();
//                           sum = newList.fold(
//                               0,
//                               (previousValue, element) =>
//                                   previousValue + element);
//                           _saveListToPreferences();
//                           _saveSum();
//                         }
//                       });
//                     },
//                     child: Text('Save')),
//               ),
//               Container(
//                 child: valueofSum(),
//                 height: 50,
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Container(
//               //color: Colors.amber,
//               height: 229,
//               width: 500,
//               //color: Colors.amber,
//               //child: newtext[],
//               child: ListView.builder(
//                 itemCount: _list.length,
//                 itemBuilder: (_, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 4, bottom: 4),
//                     child: ListTile(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(width: 3, color: Colors.green),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       tileColor: Colors.white,
//                       title: Text(
//                         'Day${index + 1} -  ${_list[index]}',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.grey.shade500),
//                         onPressed: () {
//                           setState(() {
//                             _list.removeAt(index);

//                             _saveListToPreferences();
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _saveListToPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('list', _list);
//   }

//   void _loadListFromPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final list = prefs.getStringList('list');
//     if (list != null) {
//       setState(() {
//         _list = list;
//       });
//     }
//   }

//   void _saveSum() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt('sum', sum);
//   }

//   void _loadSum() async {
//     final prefs = await SharedPreferences.getInstance();
//     final sumnew = prefs.getInt('sum');
//     if (sumnew != null) {
//       sum = sumnew;
//     }
//   }
// }
