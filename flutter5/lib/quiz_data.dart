
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizSubject {
  final String name;
  final List<Question> questions;

  const QuizSubject({
    required this.name,
    required this.questions,
  });
}

final List<QuizSubject> quizSubjects = [
  QuizSubject(
    name: 'Data Structures',
    questions: [
      Question(
        questionText: 'What is the time complexity of a binary search?',
        options: ['O(n)', 'O(log n)', 'O(n^2)', 'O(1)'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'Which data structure uses LIFO? ',
        options: ['Queue', 'Stack', 'Array', 'Linked List'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizSubject(
    name: 'Operating Systems',
    questions: [
      Question(
        questionText: 'Which of the following is not an operating system?',
        options: ['Windows', 'Linux', 'Oracle', 'macOS'],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'What is a deadlock?',
        options: [
          'A situation where two or more processes are waiting for each other to release a resource',
          'A situation where a process is waiting for a resource that is not available',
          'A situation where a process is running for a long time',
          'A situation where a process is terminated by the operating system'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
];
