
import 'package:flutter/material.dart';
import 'package:flutter5/quiz_data.dart';
import 'package:flutter5/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Quiz Subjects'),
      ),
      body: ListView.builder(
        itemCount: quizSubjects.length,
        itemBuilder: (context, index) {
          final subject = quizSubjects[index];
          return ListTile(
            title: Text(subject.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(subject: subject),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
