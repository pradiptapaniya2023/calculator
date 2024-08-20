import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'calculator.dart';

class SpleshScreen extends StatelessWidget {
  const SpleshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    forNavigator(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset("assets/lottie/Animation - 1724158075352.json"),
        ));
  }

  void forNavigator(BuildContext context) {
    Future.delayed(Duration(seconds: 4)).then(
      (value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Mycalculator();
          },
        ));
      },
    );
  }
}
