import 'package:bmi_calculator/helpers/database_helpers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                print('Save');
                // _save();
                _read();
              });
            },
            child: Center(child: Text('Save')),
          )),
          RaisedButton(
            onPressed: () {
              _save();
              // Navigate back to first route when tapped.
            },
            child: Text('Go back!'),
          ),
        ],
      )),
    );
  }

  _read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    var rng = new Random();

    int rowId = 1;
    Word word = await helper.queryWord(rowId);
    if (word == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${word.word} ${word.frequency}');
    }
  }

  _save() async {
    var rng = new Random();
    Word word = Word();
    int rowId = 1; //rng.nextInt(100);
    word.word = 'hello-' + rowId.toString();
    word.frequency = 15;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(word);
    print('inserted row: $id');
  }
}
