import 'package:flutter/material.dart';

class BMI extends StatelessWidget {
  BMI({@required this.resultBMI, this.resultText});
  String resultBMI;
  String resultText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Resault"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultText,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: Colors.blue),
          ),
          Text(
            resultBMI,
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate back to first route when tapped.
            },
            child: Text('Go back!'),
          ),
        ],
      )),
    );
  }
}
