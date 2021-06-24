import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home:SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String result = "0";
  String equation = "0";
  String expression = "";
  double equationSize = 38.0;
  double resultSize = 48.0;


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationSize = 38.0;
        resultSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationSize = 48.0;
        resultSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationSize = 38.0;
        resultSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationSize = 48.0;
        resultSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1E8EB),
      appBar:AppBar(title: Text("Calculator"),
      backgroundColor: Color(0xff7952B3),),
      body:Column(
        children: <Widget> [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationSize),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultSize),),
          ),

          Expanded(child: Divider()),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width:MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Color(0xffFFC107)),
                        buildButton("⌫", 1, Color(0xff7952B3)),
                        buildButton("+", 1, Color(0xff7952B3)),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Color(0xff7952B3)),
                          buildButton("8", 1, Color(0xff7952B3)),
                          buildButton("9", 1, Color(0xff7952B3)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Color(0xff7952B3)),
                          buildButton("5", 1, Color(0xff7952B3)),
                          buildButton("6", 1, Color(0xff7952B3)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Color(0xff7952B3)),
                          buildButton("2", 1, Color(0xff7952B3)),
                          buildButton("3", 1, Color(0xff7952B3)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Color(0xff7952B3)),
                          buildButton("0", 1, Color(0xff7952B3)),
                          buildButton("00", 1, Color(0xff7952B3)),
                        ]
                    ),

                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("x", 1 , Color(0xff7952B3)),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1 , Color(0xff7952B3)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1 , Color(0xff7952B3)),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2 , Color(0xffFFC107)),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}



