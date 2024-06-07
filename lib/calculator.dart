import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Mycalculator extends StatefulWidget {
  @override
  State<Mycalculator> createState() => State_Mycalculator();
}

class State_Mycalculator extends State<Mycalculator> {
  int firstNum = 0;
  int secondNum = 0;
  String history = '';
  String textToDisplay = '';
  String operation = '';
  bool isZeroTapped = true;
  bool isEqualButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16),
            child: Text(
              history,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(16),
            child: Text(
              textToDisplay,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(Colors.grey, "Cl"),
                MyButton(Colors.grey, "+/-"),
                MyButton(Colors.grey, "%"),
                MyButton(Colors.yellow, "/")
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(Colors.grey, "7"),
                MyButton(Colors.grey, "8"),
                MyButton(Colors.grey, "9"),
                MyButton(Colors.yellow, "*")
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(Colors.grey, "4"),
                MyButton(Colors.grey, "5"),
                MyButton(Colors.grey, "6"),
                MyButton(Colors.yellow, "-")
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(Colors.grey, "1"),
                MyButton(Colors.grey, "2"),
                MyButton(Colors.grey, "3"),
                MyButton(Colors.yellow, "+")
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(Colors.grey, "."),
                MyButton(Colors.grey, "0"),
                MyButton(Colors.grey, "⌫"),
                MyButton(Colors.yellow, "=")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget MyButton(MaterialColor color, String s) {
    return Card(
      elevation: 15,
      shadowColor: Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      child: InkWell(
        onTap: () => onBtnTap(s),
        child: Container(
          height: 100,
          width: 100,
          child: Center(
              child: Text(
            s,
            style: TextStyle(fontSize: 40),
          )),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
      ),
    );
  }

  void onBtnTap(String s) {
    debugPrint("===[$s]===");
    if (s == "Cl") {
      clearAll();
    } else if (s == "+" || s == "-" || s == "*" || s == "/" || s == "%") {
      setState(() {
        _beforeoprend(s);
      });
    } else if (s == "=") {
      if (textToDisplay.isNotEmpty) {
        setState(() {
          _operationForEqual();
        });
        isEqualButtonPressed = true;
      }
    } else if (s == "+/-") {
      setState(() {
        if (textToDisplay.startsWith("-")) {
          textToDisplay = textToDisplay.split("-")[1];
        } else {
          textToDisplay = "-${int.parse(textToDisplay)}";
        }
      });
    } else if (s == "⌫") {
      setState(() {
        textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
      });
    } else if (s == "0") {
      if (textToDisplay.isEmpty || textToDisplay == "0") {
        setState(() {
          textToDisplay = "0";
        });
      } else if (textToDisplay.isNotEmpty) {
        setState(() {
          textToDisplay += s;
        });
      }
    } else {
      setState(() {
        textToDisplay += s;
        if (isEqualButtonPressed) {
          history = "";
          isEqualButtonPressed = true;
        }
      });

      debugPrint("===[Text to Display : $textToDisplay]===");
    }
  }

  void _beforeoprend(String s) {
    setState(() {
      if (textToDisplay.isNotEmpty) {
        int storeFirstVal = firstNum;
        firstNum = int.parse(textToDisplay);
        operation = s;

        if (isEqualButtonPressed) {
          history = '';
          isEqualButtonPressed = false;
        }

        if (operation == '+') {
          firstNum = firstNum + storeFirstVal;
        }
        if (operation == '-') {
          firstNum = storeFirstVal - firstNum;
        }
        if (operation == '*') {
          firstNum = storeFirstVal * firstNum;
        }
        if (operation == '/') {
          firstNum = storeFirstVal % firstNum;
        }

        history += textToDisplay + operation;
        textToDisplay = '';

        debugPrint("===[First : $firstNum]===");
        debugPrint("===[Temp : $storeFirstVal]===");
        debugPrint("===[Second : $secondNum]===");
        debugPrint("===[History : $history]===");
        debugPrint("===[Text  : $textToDisplay]===");
      }
    });
  }

  void _operationForEqual() {
    setState(() {
      secondNum = int.parse(textToDisplay);
      if (operation == '+') {
        textToDisplay = (firstNum + secondNum).toString();
      }
      if (operation == '-') {
        textToDisplay = (firstNum - secondNum).toString();
      }
      if (operation == '*') {
        textToDisplay = (firstNum * secondNum).toString();
      }
      if (operation == '/') {
        textToDisplay = (firstNum / secondNum).toString();
      }
      if (operation == '%') {
        textToDisplay = (firstNum * secondNum / 100).toString();
      }
      _resetEqual();
      // history += textToDisplay ;
      // textToDisplay = '';
    });
  }

  void _resetEqual() {
    history = '';
    operation = '';
    firstNum = 0;
    secondNum = 0;
  }

  void clearAll() {
    setState(() {
      firstNum = 0;
      secondNum = 0;
      history = '';
      textToDisplay = '';
      operation = '';
    });
  }
}
