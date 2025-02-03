import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jack Mannis Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jack Mannis Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});

          _result = ' = $result';
        } catch (e) {
          _result = 'Error. Do it again....';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(114, 134, 200, 1))),
        onPressed: () => _onPressed(value),
        child: Text(
          value,
          style: TextStyle(
              fontSize: 24, decorationColor: Color.fromARGB(255, 134, 200, 1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jack Mannis Awesome Calculator'),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 32, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
              Row(
                children: [
                  _buildButton('C'),
                  _buildButton('%'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
