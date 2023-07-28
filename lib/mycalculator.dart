import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List buttons=[
    '7','8','9','/',
    '6','5','4','+',
    '3','2','1','*',
    'C','0','=','-'
  ];
  String _input = '';
  double _result = 0.0;

  void _onBtnPressed(String buttonText){
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _result = 0.0;
      }else if(buttonText == '='){
        try {
          _result = evalExpression(_input);
          _input = _result.toString();
        }catch (e){
          _input ='Error';
        }
        }else{
        _input += buttonText;
      }
    });
  }
  double evalExpression(String expression){
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);
      return double.parse(evalResult.toStringAsFixed(2));
    }catch (e) {
        throw Exception("Invalid expression");
      }

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.cyan,
    body: Column(
      children:[
      Expanded(
    child: Container(
    alignment: Alignment.bottomRight,
    child: Text(
      _input,
      style:TextStyle(fontSize: 63,color: Colors.black),
    ),
    ),
    ),
    Divider(height: 1,),
    Expanded(
      flex: 2,
      child: Container(
      child: GridView.builder(itemCount: buttons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4),
      itemBuilder: (context,index) {
        return ElevatedButton(
            onPressed: () {},

            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow),
            child: Text(
              buttons[index],style:TextStyle(
              fontSize: 30,
              color:Colors.amber,
            ) ,)
        );
      },

      )

  ),
    )



    ],
    ),





  );
  }
}
