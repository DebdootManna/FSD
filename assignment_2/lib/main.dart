import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Fun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C4DFF)),
        useMaterial3: true,
        textTheme: Theme.of(
          context,
        ).textTheme.apply(displayColor: Colors.white, bodyColor: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}

enum Operation { add, subtract, multiply, divide }

extension OperationX on Operation {
  String get label => switch (this) {
    Operation.add => 'Addition',
    Operation.subtract => 'Subtraction',
    Operation.multiply => 'Multiplication',
    Operation.divide => 'Division',
  };

  String get emoji => switch (this) {
    Operation.add => '➕',
    Operation.subtract => '➖',
    Operation.multiply => '✖️',
    Operation.divide => '➗',
  };

  List<Color> get colors => switch (this) {
    Operation.add => [const Color(0xFF00E5FF), const Color(0xFF2979FF)],
    Operation.subtract => [const Color(0xFFFFD54F), const Color(0xFFFF7043)],
    Operation.multiply => [const Color(0xFF69F0AE), const Color(0xFF00C853)],
    Operation.divide => [const Color(0xFFFF80AB), const Color(0xFFEA80FC)],
  };
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ops = Operation.values;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFF00BCD4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Math Fun!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Learn +, −, ×, ÷ with smiles',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.05,
                  ),
                  itemCount: ops.length,
                  itemBuilder: (context, i) {
                    final op = ops[i];
                    return _OperationCard(
                      operation: op,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PracticeScreen(operation: op),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OperationCard extends StatelessWidget {
  final Operation operation;
  final VoidCallback onTap;
  const _OperationCard({required this.operation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: operation.colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(operation.emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              Text(
                operation.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PracticeScreen extends StatefulWidget {
  final Operation operation;
  const PracticeScreen({super.key, required this.operation});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  static const int totalQuestions = 10;
  final _rand = Random();

  int questionIndex = 0;
  int score = 0;
  late _Question current;
  int? selectedAnswer;
  bool? isCorrect;

  int maxNumber = 10; // difficulty slider upper bound

  @override
  void initState() {
    super.initState();
    current = _makeQuestion();
  }

  _Question _makeQuestion() {
    int a, b, answer;
    switch (widget.operation) {
      case Operation.add:
        a = _rand.nextInt(maxNumber) + 1;
        b = _rand.nextInt(maxNumber) + 1;
        answer = a + b;
        break;
      case Operation.subtract:
        a = _rand.nextInt(maxNumber) + 1;
        b = _rand.nextInt(maxNumber) + 1;
        if (a < b) {
          final t = a;
          a = b;
          b = t;
        }
        answer = a - b;
        break;
      case Operation.multiply:
        a = _rand.nextInt(maxNumber) + 1;
        b = _rand.nextInt(maxNumber) + 1;
        answer = a * b;
        break;
      case Operation.divide:
        b = _rand.nextInt(maxNumber) + 1; // divisor 1..max
        final m = _rand.nextInt(maxNumber) + 1; // multiplier 1..max
        a = b * m; // ensures clean division
        answer = a ~/ b;
        break;
    }

    final options = _makeOptions(answer);
    return _Question(a: a, b: b, answer: answer, options: options);
  }

  List<int> _makeOptions(int answer) {
    final set = <int>{answer};
    while (set.length < 4) {
      final delta = _rand.nextInt(6) + 1; // 1..6
      final sign = _rand.nextBool() ? 1 : -1;
      final v = max(0, answer + sign * delta);
      set.add(v);
    }
    final list = set.toList()..shuffle(_rand);
    return list;
  }

  void _onAnswer(int value) {
    if (selectedAnswer != null) return; // already answered
    setState(() {
      selectedAnswer = value;
      isCorrect = value == current.answer;
      if (isCorrect!) score++;
    });
  }

  void _next() {
    if (questionIndex + 1 >= totalQuestions) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => SummaryScreen(
            operation: widget.operation,
            score: score,
            total: totalQuestions,
          ),
        ),
      );
      return;
    }
    setState(() {
      questionIndex++;
      selectedAnswer = null;
      isCorrect = null;
      current = _makeQuestion();
    });
  }

  String _symbol(Operation op) => switch (op) {
    Operation.add => '+',
    Operation.subtract => '−',
    Operation.multiply => '×',
    Operation.divide => '÷',
  };

  @override
  Widget build(BuildContext context) {
    final colors = widget.operation.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.operation.label),
        backgroundColor: colors.last,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      'Q${questionIndex + 1}/$totalQuestions',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '$score',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Difficulty slider card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.speed, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'Difficulty',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Slider(
                            value: maxNumber.toDouble(),
                            min: 5,
                            max: 20,
                            divisions: 15,
                            label: maxNumber.toString(),
                            onChanged: (v) => setState(() {
                              maxNumber = v.round();
                              // Regenerate a question on difficulty change only if not answered yet
                              if (selectedAnswer == null)
                                current = _makeQuestion();
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Question card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white24, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 28.0,
                            horizontal: 12,
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${current.a}  ${_symbol(widget.operation)}  ${current.b}',
                                style: const TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Pick the right answer',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Options
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (final option in current.options)
                            _AnswerButton(
                              label: option.toString(),
                              onTap: () => _onAnswer(option),
                              state: selectedAnswer == null
                                  ? _AnswerState.idle
                                  : option == current.answer
                                  ? _AnswerState.correct
                                  : option == selectedAnswer
                                  ? _AnswerState.wrong
                                  : _AnswerState.idle,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: selectedAnswer == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isCorrect == true
                                        ? Icons.celebration
                                        : Icons.refresh,
                                    color: isCorrect == true
                                        ? Colors.limeAccent
                                        : Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isCorrect == true
                                        ? 'Yay! Correct!'
                                        : 'Oops! It\'s ${current.answer}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: selectedAnswer == null ? null : _next,
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          questionIndex + 1 >= totalQuestions
                              ? 'Finish'
                              : 'Next',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: colors.last,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final _AnswerState state;
  const _AnswerButton({
    required this.label,
    required this.onTap,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg = Colors.white;
    switch (state) {
      case _AnswerState.idle:
        bg = Colors.white.withValues(alpha: 0.18);
        break;
      case _AnswerState.correct:
        bg = Colors.greenAccent.shade400;
        fg = Colors.black;
        break;
      case _AnswerState.wrong:
        bg = Colors.redAccent.shade200;
        break;
    }
    return SizedBox(
      width: 160,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: state == _AnswerState.idle ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: fg,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _AnswerState { idle, correct, wrong }

class _Question {
  final int a;
  final int b;
  final int answer;
  final List<int> options;
  _Question({
    required this.a,
    required this.b,
    required this.answer,
    required this.options,
  });
}

class SummaryScreen extends StatelessWidget {
  final Operation operation;
  final int score;
  final int total;
  const SummaryScreen({
    super.key,
    required this.operation,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (score / total * 100).round();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: operation.colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(operation.emoji, style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 8),
                  Text(
                    operation.label,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24, width: 2),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 22,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$score / $total',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$percent%',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) =>
                                PracticeScreen(operation: operation),
                          ),
                        ),
                        icon: const Icon(Icons.replay),
                        label: const Text('Play again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: operation.colors.last,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () =>
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                              (route) => false,
                            ),
                        icon: const Icon(Icons.home, color: Colors.white),
                        label: const Text('Home'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
