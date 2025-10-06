
import 'package:flutter/material.dart';
import 'package:flutter5/quiz_data.dart';
import 'package:flutter5/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizSubject subject;

  const QuizScreen({super.key, required this.subject});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex ==
        widget.subject.questions[_questionIndex].correctAnswerIndex) {
      _score++;
    }

    if (_questionIndex < widget.subject.questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: widget.subject.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.subject.questions[_questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_questionIndex + 1}/${widget.subject.questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ...question.options.asMap().entries.map((entry) {
              int idx = entry.key;
              String text = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(idx),
                  child: Text(text),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
