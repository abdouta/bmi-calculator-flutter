import 'package:bmi_calculator/NavDrawer.dart';
import 'package:bmi_calculator/bmi.dart';
import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/icon_content.dart';
import 'package:bmi_calculator/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const activeCardColor = Colors.blue;
const inactiveCardColor = Color(0XFF1d2845);
enum Gender { male, female }

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0XFF1d2845),
          accentColor: Colors.blue,
          scaffoldBackgroundColor: Color(0XFF28375e),
          textTheme: TextTheme(body1: TextStyle(color: Colors.white))),
      home: InputPage(),
      routes: {'profile': (context) => Profile(), 'bmi': (context) => BMI()},
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = activeCardColor;
  Color femaleCardColor = inactiveCardColor;
  int height = 180;
  int weight = 70;
  int age = 18;

  updateCardGender(Gender selectedGender) {
    if (selectedGender == Gender.male) {
      maleCardColor = activeCardColor;
      femaleCardColor = inactiveCardColor;
    } else {
      femaleCardColor = activeCardColor;
      maleCardColor = inactiveCardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('BMI CALCULATOR '),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateCardGender(Gender.male);
                        print('Male');
                      });
                    },
                    child: ReusableCard(
                      colour: maleCardColor,
                      childCart: Center(
                          child: IconContent(
                        lable: 'Male',
                        icon: FontAwesomeIcons.male,
                      )),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateCardGender(Gender.female);
                        print('Female');
                      });
                    },
                    child: ReusableCard(
                        colour: femaleCardColor,
                        childCart: Container(
                            child: IconContent(
                          lable: 'Female',
                          icon: FontAwesomeIcons.female,
                        ))),
                  )),
            ],
          ),
          Expanded(
            flex: 1,
            child: ReusableCard(
                colour: Color(0XFF1d2845),
                childCart: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Hieght',
                      style: KlabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: KBigNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: KlabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          onChanged: (double newVal) {
                            setState(() {
                              height = newVal.round();
                            });
                          }),
                    )
                  ],
                )),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ReusableCard(
                    colour: Color(0XFF1d2845),
                    childCart: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Weight',
                          style: KlabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: KBigNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onClick: () {
                                setState(() {
                                  weight += 1;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onClick: () {
                                setState(() {
                                  weight -= 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: ReusableCard(
                    colour: Color(0XFF1d2845),
                    childCart: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Age',
                          style: KlabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: KBigNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onClick: () {
                                setState(() {
                                  age += 1;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onClick: () {
                                setState(() {
                                  age -= 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  CalculatorBrain cb =
                      new CalculatorBrain(height: height, weight: weight);
//                  Navigator.pushNamed(
//                    context,
//                    'bmi',
//                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BMI(
                                resultBMI: cb.Calc(),
                                resultText: cb.getResaultText(),
                              )));
                  print('Calc');
                });
              },
              child: Container(
                  width: double.infinity,
                  color: Colors.blue, //Color.fromRGBO(181, 0, 39, 1),
                  height: 40.0,
                  child: Center(
                      child: Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  )))),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget childCart;

  ReusableCard({@required this.colour, @required this.childCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: childCart,
      height: 150.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: colour, borderRadius: BorderRadius.circular(10.0)),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, this.onClick});

  final IconData icon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onClick,
      child: Icon(
        icon,
        size: 14.0,
      ),
      constraints: BoxConstraints.tightFor(width: 50.0, height: 50.0),
      shape: CircleBorder(),
      fillColor: Colors.blue,
    );
  }
}
