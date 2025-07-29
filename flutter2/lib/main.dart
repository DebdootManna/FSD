import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 1;
  String message = ""; // To display warning messages

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("MyApp"), backgroundColor: Colors.teal),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter Value is $counter", style: TextStyle(fontSize: 45)),
            SizedBox(height: 10),
            Text(message, style: TextStyle(fontSize: 20, color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: incrementCounter,
              child: Text("+"),
            ),
            ElevatedButton(
              onPressed: decrementCounter,
              child: Text("-"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter = 0;
                  message = "";
                });
              },
              child: Text("X"),
            ),
          ],
        ),
      ),
    );
  }

  void incrementCounter() {
    if (counter >= 5) {
      setState(() {
        message = "Counter can't be more than 5!";
      });
    } else {
      setState(() {
        counter++;
        message = "";
      });
    }
  }

  void decrementCounter() {
    if (counter <= 0) {
      setState(() {
        message = "Counter can't be less than 0!";
      });
    } else {
      setState(() {
        counter--;
        message = "";
      });
    }
  }
}