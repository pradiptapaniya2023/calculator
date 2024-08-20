import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Mycalculator extends StatefulWidget {
  @override
  State<Mycalculator> createState() => State_Mycalculator();
}

class State_Mycalculator extends State<Mycalculator> {
  bool isZeroTapped = true;
  double firstNum = 0;
  double secondNum = 0;
  String history = '';
  String textToDisplay = '';
  String operation = '';
  bool isEqualButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 20, bottom: 20),
              child: Text(
                history,
                style: TextStyle(
                  fontSize: 33,
                  color: Colors.white.withOpacity(0.2),
                ),
                maxLines: 5,
              ),
              margin: EdgeInsets.all(5),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              height: 150,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 20, bottom: 20),
              child: Text(
                textToDisplay,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              margin: EdgeInsets.all(5),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(Colors.grey, "C"),
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
      ),
    );
  }

  Widget MyButton(MaterialColor color, String s) {
    return Expanded(
      child: InkWell(
        hoverColor: Colors.black,
        onTap: () => onBtnTap(s),
        child: Card(
          elevation: 20,
          color: Colors.black,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: s == "+" || s == "-" || s == "*" || s == "/"
                    ? Colors.orange.shade300
                    : s == "C"
                        ? Colors.red.shade400
                        : Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                s,
                style: TextStyle(fontSize: 33),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(String s) {
    debugPrint("===[$s]===");
    if (s == "C") {
      clearAll();
    } else if (s == "+" || s == "-" || s == "*" || s == "/" || s == "%") {
      setState(() {
        _operation(s);
      });
    } else if (s == "=") {
      if (textToDisplay.isNotEmpty) {
        setState(() {
          history += textToDisplay;
        });
        _operationForEqual();
        isEqualButtonPressed = true;
      }
    } else if (s == "+/-") {
      setState(() {
        if (textToDisplay.startsWith("-")) {
          textToDisplay = textToDisplay.split("-")[1];
        } else {
          textToDisplay = "-${double.parse(textToDisplay)}";
        }
      });
    } else if (s == "⌫") {
      setState(() {
        textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
      });
    } else {
      setState(() {
        if (s == "." && textToDisplay.contains(".")) {
          return;
        }
        textToDisplay += s;
        if (isEqualButtonPressed) {
          history = " ";
          isEqualButtonPressed = false;
        }
      });
      debugPrint("===[Text to Display : $textToDisplay]===");
    }
  }

  void _operation(String opration) {
    setState(() {
      double tempVar = firstNum;
      firstNum = double.parse(textToDisplay);

      if (operation == '+') {
        firstNum = tempVar + firstNum;
      }
      if (operation == '-') {
        firstNum = tempVar - firstNum;
      }
      if (operation == '*') {
        firstNum = tempVar * firstNum;
      }
      if (operation == '/') {
        firstNum = tempVar / firstNum;
      }
      operation = opration;
      if (isEqualButtonPressed) {
        history = '';
        isEqualButtonPressed = false;
      }
      history = textToDisplay + operation;
      textToDisplay = '';
      debugPrint("===[First : $firstNum]===");
      debugPrint("===[Temp : $tempVar]===");
      debugPrint("===[Second : $secondNum]===");
      debugPrint("===[History : $history]===");
      debugPrint("===[Text  : $textToDisplay]===");
    });
  }

  void _operationForEqual() {
    setState(() {
      secondNum = double.parse(textToDisplay);
      textToDisplay = "";

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
    });
  }

  void _resetEqual() {
    history = ' ';
    operation = ' ';
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
