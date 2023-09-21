import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';

  // void _appendNumber(int number) {
  //   setState(() {
  //     _displayText += number.toString();
  //   });
  // }
  void _appendNumber(dynamic number) {
    setState(() {
      _displayText += number.toString();
    });
  }

  void _clear() {
    setState(() {
      _displayText = '';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
    });
  }

  // void _setOperator(String operator) {
  //   setState(() {
  //     _firstOperand = double.parse(_displayText);
  //     _displayText = '';
  //     _operator = operator;
  //   });
  // }

  void _setOperator(String operator) {
    setState(() {
      _displayText += operator;
      _operator = operator;
    });
  }

  // void _calculate() {
  //   setState(() {
  //     _secondOperand = double.parse(_displayText);
  //     double result = 0;
  //     switch (_operator) {
  //       case '+':
  //         result = _firstOperand + _secondOperand;
  //         break;
  //       case '-':
  //         result = _firstOperand - _secondOperand;
  //         break;
  //       case '*':
  //         result = _firstOperand * _secondOperand;
  //         break;
  //       case '/':
  //         result = _firstOperand / _secondOperand;
  //         break;
  //     }
  //     _displayText = result.toString();
  //     _firstOperand = 0;
  //     _secondOperand = 0;
  //     _operator = '';
  //   });
  // }
  void _calculate() {
    setState(() {
      // 解析用户输入的表达式
      String expression = _displayText;
      List<String> parts = expression.split(RegExp(r'(\+|\-|\*|\/)'));
      if (parts.length == 2) {
        _firstOperand = double.parse(parts[0]);
        _secondOperand = double.parse(parts[1]);

        // 执行计算
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

        // 显示计算结果
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton(text: '1', onPressed: () => _appendNumber(1)),
              CalculatorButton(text: '2', onPressed: () => _appendNumber(2)),
              CalculatorButton(text: '3', onPressed: () => _appendNumber(3)),
              CalculatorButton(text: '+', onPressed: () => _setOperator('+')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton(text: '4', onPressed: () => _appendNumber(4)),
              CalculatorButton(text: '5', onPressed: () => _appendNumber(5)),
              CalculatorButton(text: '6', onPressed: () => _appendNumber(6)),
              CalculatorButton(text: '-', onPressed: () => _setOperator('-')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton(text: '7', onPressed: () => _appendNumber(7)),
              CalculatorButton(text: '8', onPressed: () => _appendNumber(8)),
              CalculatorButton(text: '9', onPressed: () => _appendNumber(9)),
              CalculatorButton(text: '*', onPressed: () => _setOperator('*')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton(text: '0', onPressed: () => _appendNumber(0)),
              CalculatorButton(text: '.', onPressed: () => _appendNumber('.')),
              CalculatorButton(text: '=', onPressed: _calculate),
              CalculatorButton(text: '/', onPressed: () => _setOperator('/')),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _clear,
              child: const Text('Clear'),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        // 设置按钮的背景颜色
        onPrimary: Colors.white,
        // 设置按钮上文本的颜色
        textStyle: TextStyle(fontSize: 16),
        // 设置按钮上文本的样式
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // 设置按钮内边距
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // 设置按钮的形状
        elevation: 2, // 设置按钮的阴影高度
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
