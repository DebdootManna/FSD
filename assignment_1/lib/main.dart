import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorSchemeSeed: const Color(0xFF6C63FF),
      useMaterial3: true,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Learn ABC & 123',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.fredokaTextTheme(baseTheme.textTheme),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Learn & Play')),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose a game',
                    style: GoogleFonts.fredoka(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _HomeBigButton(
                    label: 'Learn ABC',
                    icon: Icons.abc,
                    colors: const [Color(0xFFFFC371), Color(0xFFFF5F6D)],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AbcScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _HomeBigButton(
                    label: 'Learn 123',
                    icon: Icons.onetwothree,
                    colors: const [Color(0xFF42E695), Color(0xFF3BB2B8)],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NumbersScreen()),
                    ),
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

class _HomeBigButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;
  const _HomeBigButton({
    required this.label,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_HomeBigButton> createState() => _HomeBigButtonState();
}

class _HomeBigButtonState extends State<_HomeBigButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 36),
              const SizedBox(width: 16),
              Text(
                widget.label,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AbcScreen extends StatefulWidget {
  const AbcScreen({super.key});

  @override
  State<AbcScreen> createState() => _AbcScreenState();
}

class _AbcScreenState extends State<AbcScreen> {
  final List<_LetterItem> _letters = _lettersData;
  final _tts = TtsService.instance;
  String? _lastSaid;

  @override
  void initState() {
    super.initState();
    _tts.configure();
  }

  Future<void> _playAll() async {
    for (final l in _letters) {
      await _tts.speak('${l.letter} for ${l.word}');
    }
    if (mounted) setState(() => _lastSaid = 'Great job!');
  }

  @override
  Widget build(BuildContext context) {
    return _GradientScaffold(
      title: 'Learn ABC',
      actions: [
        IconButton(
          tooltip: 'Play all',
          icon: const Icon(Icons.play_circle_fill, color: Colors.white),
          onPressed: _playAll,
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1,
              ),
              itemCount: _letters.length,
              itemBuilder: (context, index) {
                final item = _letters[index];
                return _BouncyCard(
                  background: _funColors[index % _funColors.length],
                  onTap: () async {
                    setState(
                      () => _lastSaid = '${item.letter} for ${item.word}',
                    );
                    await _tts.speak('${item.letter} for ${item.word}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 6),
                      Text(
                        item.letter,
                        style: GoogleFonts.fredoka(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.word,
                        style: GoogleFonts.fredoka(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_lastSaid != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                _lastSaid!,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  final _tts = TtsService.instance;
  final List<_NumberItem> _numbers = _numbersData;
  String? _lastSaid;

  @override
  void initState() {
    super.initState();
    _tts.configure();
  }

  Future<void> _playAll() async {
    for (final n in _numbers) {
      await _tts.speak('${n.value} - ${n.word}');
    }
    if (mounted) setState(() => _lastSaid = 'You counted to 10!');
  }

  @override
  Widget build(BuildContext context) {
    return _GradientScaffold(
      title: 'Learn 123',
      actions: [
        IconButton(
          tooltip: 'Play all',
          icon: const Icon(Icons.play_circle_fill, color: Colors.white),
          onPressed: _playAll,
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1,
              ),
              itemCount: _numbers.length,
              itemBuilder: (context, index) {
                final item = _numbers[index];
                return _BouncyCard(
                  background: _funColors[(index + 2) % _funColors.length],
                  onTap: () async {
                    setState(() => _lastSaid = '${item.value} - ${item.word}');
                    await _tts.speak('${item.value} - ${item.word}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.value.toString(),
                        style: GoogleFonts.fredoka(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.word,
                        style: GoogleFonts.fredoka(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_lastSaid != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                _lastSaid!,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GradientScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  const _GradientScaffold({
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(title),
          actions: actions,
        ),
        body: SafeArea(child: child),
      ),
    );
  }
}

class TtsService {
  TtsService._();
  static final instance = TtsService._();
  final FlutterTts _tts = FlutterTts();
  bool _configured = false;

  Future<void> configure() async {
    if (_configured) return;
    // Configure sensible defaults for kids-friendly speech.
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45); // slower
    await _tts.setPitch(1.05); // slightly higher pitch
    await _tts.setVolume(1.0);
    await _tts.awaitSpeakCompletion(true);
    _configured = true;
  }

  Future<void> speak(String text) async {
    await configure();
    await _tts.stop(); // stop any ongoing speech
    await _tts.speak(text);
  }
}

class _BouncyCard extends StatefulWidget {
  final Widget child;
  final Color background;
  final VoidCallback? onTap;
  const _BouncyCard({
    required this.child,
    required this.background,
    this.onTap,
  });

  @override
  State<_BouncyCard> createState() => _BouncyCardState();
}

class _BouncyCardState extends State<_BouncyCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 110),
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _LetterItem {
  final String letter;
  final String word;
  final String emoji;
  const _LetterItem(this.letter, this.word, this.emoji);
}

class _NumberItem {
  final int value;
  final String word;
  const _NumberItem(this.value, this.word);
}

const List<Color> _funColors = [
  Color(0xFFFF8A80),
  Color(0xFFFFD180),
  Color(0xFFFFF59D),
  Color(0xFFA7FFEB),
  Color(0xFF80D8FF),
  Color(0xFFB388FF),
];

const List<_LetterItem> _lettersData = [
  _LetterItem('A', 'Apple', '🍎'),
  _LetterItem('B', 'Ball', '🏀'),
  _LetterItem('C', 'Cat', '🐱'),
  _LetterItem('D', 'Dog', '🐶'),
  _LetterItem('E', 'Elephant', '🐘'),
  _LetterItem('F', 'Fish', '🐟'),
  _LetterItem('G', 'Giraffe', '🦒'),
  _LetterItem('H', 'Hat', '🎩'),
  _LetterItem('I', 'Ice cream', '🍦'),
  _LetterItem('J', 'Juice', '🧃'),
  _LetterItem('K', 'Kite', '🪁'),
  _LetterItem('L', 'Lion', '🦁'),
  _LetterItem('M', 'Monkey', '🐵'),
  _LetterItem('N', 'Nest', '🪺'),
  _LetterItem('O', 'Orange', '🍊'),
  _LetterItem('P', 'Pizza', '🍕'),
  _LetterItem('Q', 'Queen', '👑'),
  _LetterItem('R', 'Rainbow', '🌈'),
  _LetterItem('S', 'Sun', '☀️'),
  _LetterItem('T', 'Tiger', '🐯'),
  _LetterItem('U', 'Umbrella', '☂️'),
  _LetterItem('V', 'Violin', '🎻'),
  _LetterItem('W', 'Whale', '🐳'),
  _LetterItem('X', 'Xylophone', '🎶'),
  _LetterItem('Y', 'Yo-yo', '🪀'),
  _LetterItem('Z', 'Zebra', '🦓'),
];

const List<_NumberItem> _numbersData = [
  _NumberItem(1, 'One'),
  _NumberItem(2, 'Two'),
  _NumberItem(3, 'Three'),
  _NumberItem(4, 'Four'),
  _NumberItem(5, 'Five'),
  _NumberItem(6, 'Six'),
  _NumberItem(7, 'Seven'),
  _NumberItem(8, 'Eight'),
  _NumberItem(9, 'Nine'),
  _NumberItem(10, 'Ten'),
];
