import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconContent extends StatelessWidget {
  final lable;
  final icon;
  IconContent({this.lable, this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            this.icon,
            size: 60.0,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('Male'),
          )
        ]);
  }
}
