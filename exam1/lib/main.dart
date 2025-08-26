import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String display = '0';
  String previousNumber = '';
  String operation = '';
  bool Operand = false;

  void inputNumber(String number) {
    setState(() {
      if (Operand) {
        display = number;
        Operand = false;
      } else {
        display = display == '0' ? number : display + number;
      }
    });
  }

  void inputOperation(String nextOperation) {
    setState(() {
      if (previousNumber.isEmpty) {
        previousNumber = display;
      } else if (!Operand) {
        calculate();
      }
      Operand = true;
      operation = nextOperation;
    });
  }

  void calculate() {
    double result;
    double num1 = double.parse(previousNumber);
    double num2 = double.parse(display);
    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      default:
        return;
    }
    setState(() {
      display = result == result.toInt() ? result.toInt().toString() : result.toString();
      previousNumber = '';
      operation = '';
      Operand = true;
    });
  }

  void clear() {
    setState(() {
      display = '0';
      previousNumber = '';
      operation = '';
      Operand = false;
    });
  }
  Widget buildButton(String text, {Color? color, VoidCallback? onPressed}) {
    return Expanded(
      child: Container(
        height: 60,
        margin: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            foregroundColor: Colors.black,
          ),
          onPressed: onPressed,
          child: Text(
            text
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          // the main Display..!
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            height: 100,
            child: Text(
              display,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          // Buttons are present here!!!!
          Expanded(child: Column(
            children: [
              Row(
                children: [
                  buildButton('7', color: Colors.blue, onPressed: () => inputNumber('7')),
                  buildButton('8', color: Colors.blue, onPressed: () => inputNumber('8')),
                  buildButton('9', color: Colors.blue, onPressed: () => inputNumber('9')),
                  buildButton('/', color: Colors.blue, onPressed: () => inputOperation('/')),
                ],
              ),
              Row(
                children: [
                  buildButton('4', color: Colors.blue, onPressed: () => inputNumber('4')),
                  buildButton('5', color: Colors.blue, onPressed: () => inputNumber('5')),
                  buildButton('6', color: Colors.blue, onPressed: () => inputNumber('6')),
                  buildButton('*', color: Colors.blue, onPressed: () => inputOperation('*')),
                ],
              ),
              Row(
                children: [
                  buildButton('1', color: Colors.blue, onPressed: () => inputNumber('1')),
                  buildButton('2', color: Colors.blue, onPressed: () => inputNumber('2')),
                  buildButton('3', color: Colors.blue, onPressed: () => inputNumber('3')),
                  buildButton('-', color: Colors.blue, onPressed: () => inputOperation('-')),
                ],
              ),
              Row(
                children: [
                  buildButton('0', color: Colors.blue, onPressed: () => inputNumber('0')),
                  buildButton('C', color: Colors.blue, onPressed: clear),
                  buildButton('=', color: Colors.blue, onPressed: calculate),
                  buildButton('+', color: Colors.blue, onPressed: () => inputOperation('+')),
                ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}