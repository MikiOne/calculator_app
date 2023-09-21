import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.green),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  String _operator = '';
  double _firstOperand = 0;
  double _secondOperand = 0;

  void _appendNumber(int number) {
    setState(() {
      _displayText += number.toString();
    });
  }

  void _setOperator(String operator) {
    setState(() {
      _displayText += operator;
      _operator = operator;
    });
  }

  void _calculate() {
    setState(() {
      String expression = _displayText;
      List<String> parts = expression.split(RegExp(r'(\+|\-|\*|\/)'));
      if (parts.length == 2) {
        _firstOperand = double.parse(parts[0]);
        _secondOperand = double.parse(parts[1]);

        double result = 0;
        switch (_operator) {
          case '+':
            result = _firstOperand + _secondOperand;
            break;
          case '-':
            result = _firstOperand - _secondOperand;
            break;
          case '*':
            result = _firstOperand * _secondOperand;
            break;
          case '/':
            result = _firstOperand / _secondOperand;
            break;
        }

        _displayText = '$expression=$result';
        _firstOperand = 0;
        _secondOperand = 0;
        _operator = '';
      } else {
        _displayText = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 400),

            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '7',
                  onPressed: () => _appendNumber(7),
                ),
                CalculatorButton(
                  text: '8',
                  onPressed: () => _appendNumber(8),
                ),
                CalculatorButton(
                  text: '9',
                  onPressed: () => _appendNumber(9),
                ),
                CalculatorButton(
                  text: '+',
                  onPressed: () => _setOperator('+'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '4',
                  onPressed: () => _appendNumber(4),
                ),
                CalculatorButton(
                  text: '5',
                  onPressed: () => _appendNumber(5),
                ),
                CalculatorButton(
                  text: '6',
                  onPressed: () => _appendNumber(6),
                ),
                CalculatorButton(
                  text: '-',
                  onPressed: () => _setOperator('-'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '1',
                  onPressed: () => _appendNumber(1),
                ),
                CalculatorButton(
                  text: '2',
                  onPressed: () => _appendNumber(2),
                ),
                CalculatorButton(
                  text: '3',
                  onPressed: () => _appendNumber(3),
                ),
                CalculatorButton(
                  text: '*',
                  onPressed: () => _setOperator('*'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: 'C',
                  onPressed: () {
                    setState(() {
                      _displayText = '';
                      _firstOperand = 0;
                      _secondOperand = 0;
                      _operator = '';
                    });
                  },
                ),
                CalculatorButton(
                  text: '0',
                  onPressed: () => _appendNumber(0),
                ),
                CalculatorButton(
                  text: '=',
                  onPressed: _calculate,
                ),
                CalculatorButton(
                  text: '/',
                  onPressed: () => _setOperator('/'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Calculator Help'),
                      content: Text('This calculator supports basic arithmetic operations.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
