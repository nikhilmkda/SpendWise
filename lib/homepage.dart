import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/sdsxs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  TextEditingController userInput = TextEditingController();
  final _textController = TextEditingController();

  int _textnum = 0;
  int balance = 0;
  int sum = 0;

  late bool checkbool;

  List<int> newList = [];
  List<String> _list = [];

  Widget valueofSum() {
    String numberAsString = sum.toString();

    //var total = 12000 - sum;

    return Text(
      numberAsString,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget balancewidget() {
    balance = _textnum - sum;
    if (balance > 0 && sum < _textnum) {
      String numberAsString = balance.toString();

      return Text(
        numberAsString,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else
      return Text(
        'Balance is empty',
        style: TextStyle(
            fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
      );
  }

  void saveText(String text) async {
    SharedPreferences value = await SharedPreferences.getInstance();
    value.setString("text", text);
  }

  void readText() async {
    SharedPreferences value = await SharedPreferences.getInstance();
    String? savedvalue = value.getString("text");

    if (savedvalue != null) {
      userInput.text = savedvalue;
    }
  }

  void initState() {
    super.initState();
    readText();
    //readTextint();

    _loadIntValue();
    _loadListFromPreferences();
    _loadSum();
    checkFirstOpen();
  }

  void _loadIntValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textnum = prefs.getInt('intValue') ?? 0;
    });
  }

  void _saveIntValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', value);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              //for avoiding list view going through text field
              height: 400,
              color: Color.fromARGB(244, 238, 235, 249),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: FractionalOffset(0.0, 0.6),
                        child: ElevatedButton(
                          child: Icon(
                            Icons.person,
                            size: 65,
                          ), //icon s
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(2),
                            backgroundColor: Color.fromARGB(
                                255, 240, 240, 255), // <-- Button color
                            // <-- Splash color
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Container(
                                child: Text(
                                  'Hello,User Name',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Monthly Expense')),
                                    ),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Daily Expense')),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 230,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 200, right: 10),
                          child: Container(
                            height: 64,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 68, left: 210, right: 25),
                          child: valueofSum(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 1, right: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Container(
                                      child: const Text(
                                        'Income:',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      child: const Text(
                                        'Monthly Expense:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8, top: 8, bottom: 8, right: 200),
                                child: TextField(
                                  onChanged: (val) {
                                    saveText(val);
                                    int textnum = int.tryParse(userInput.text)!;
                                    if (textnum != null) {
                                      setState(() {
                                        _textnum = textnum;
                                        _saveIntValue(textnum);
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  controller: userInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        )),
                                    hintText: 'Enter Total Income',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  child: const Text(
                                    'Balance:',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 22),
                                    child: Container(
                                      child: balancewidget(),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  //color: Colors.amber,
                                  height: 320,

                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          TextField(
                                            onEditingComplete: () {
                                              setState(() {
                                                if (_textController
                                                    .text.isNotEmpty) {
                                                  _list.add(
                                                      _textController.text);
                                                  _textController.text = "";
                                                  _textController.clear();

                                                  List<int> newList = _list
                                                      .map((string) =>
                                                          int.parse(string))
                                                      .toList();
                                                  sum = newList.fold(
                                                      0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          element);
                                                  _saveListToPreferences();
                                                  _saveSum();
                                                }

                                                if (sum >= _textnum / 2 &&
                                                    checkbool == false) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      title:
                                                          const Text("Warning"),
                                                      content: const Text(
                                                        "50% of your Income  already used",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                            saveBool(true);
                                                          },
                                                          child: Container(
                                                            color:
                                                                Colors.white10,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(14),
                                                            child: const Text(
                                                                "okay"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              });
                                            },
                                            controller: _textController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color.fromARGB(
                                                          255, 9, 81, 11)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(0),
                                                  )),
                                              hintText: 'Enter Daily Expense',
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 295,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  //newtext = userExpense.text;
                                                  setState(() {
                                                    if (_textController
                                                        .text.isNotEmpty) {
                                                      _list.add(
                                                          _textController.text);
                                                      _textController.text = "";
                                                      _textController.clear();

                                                      List<int> newList = _list
                                                          .map((string) =>
                                                              int.parse(string))
                                                          .toList();
                                                      sum = newList.fold(
                                                          0,
                                                          (previousValue,
                                                                  element) =>
                                                              previousValue +
                                                              element);
                                                      _saveListToPreferences();
                                                      _saveSum();
                                                    }
                                                  });
                                                },
                                                child: Text('Save')),
                                          ),
                                          // Container(
                                          //   child: valueofSum(),
                                          //   height: 50,
                                          // )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 1),
                                        child: Container(
                                          // color: Colors.white,
                                          height: 260,
                                          width: 500,
                                          //color: Colors.amber,
                                          //child: newtext[],
                                          child: ListView.builder(
                                            itemCount: _list.length,
                                            itemBuilder: (_, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4, bottom: 4),
                                                child: ListTile(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.green),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  tileColor: Colors.white,
                                                  title: Text(
                                                    'Day${index + 1} -  ${_list[index]}',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: Colors
                                                            .grey.shade500),
                                                    onPressed: () {
                                                      setState(() {
                                                        List<int> newList =
                                                            _list
                                                                .map((string) =>
                                                                    int.parse(
                                                                        string))
                                                                .toList();
                                                        sum = sum -
                                                            newList[index];
                                                        _list.removeAt(index);
                                                        _saveSum();
                                                        _saveListToPreferences();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveBalance() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('sum', balance);
  }

  void _loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final sumnewhome = prefs.getInt('sum');
    if (sumnewhome != null) {
      balance = sumnewhome;
    }
  }

  void _saveListToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('list', _list);
  }

  void _loadListFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('list');
    if (list != null) {
      setState(() {
        _list = list;
      });
    }
  }

  void _saveSum() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('sum', sum);
  }

  void _loadSum() async {
    final prefs = await SharedPreferences.getInstance();
    final sumnew = prefs.getInt('sum');
    if (sumnew != null) {
      sum = sumnew;
    }
  }

  saveBool(bool checkbool) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstOpen', checkbool);
  }

  checkFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkbool = prefs.getBool("firstOpen") ?? true;
    // checkbool = checkValue;
    return checkbool;
  }
}
