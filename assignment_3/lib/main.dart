import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF00B3FF),
      brightness: Brightness.light,
    );
    return MaterialApp(
      title: 'Image-Word Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      home: const MatchGameScreen(),
    );
  }
}

class MatchItem {
  final String id;
  final String word;
  final IconData icon;
  final Color color;
  final String? asset; // Optional SVG asset path

  const MatchItem({
    required this.id,
    required this.word,
    required this.icon,
    required this.color,
    this.asset,
  });
}

class MatchGameScreen extends StatefulWidget {
  const MatchGameScreen({super.key});

  @override
  State<MatchGameScreen> createState() => _MatchGameScreenState();
}

class _MatchGameScreenState extends State<MatchGameScreen>
    with TickerProviderStateMixin {
  late List<MatchItem> _items;
  late List<MatchItem> _words;
  final Map<String, bool> _matched = {};
  int _round = 1;

  @override
  void initState() {
    super.initState();
    _resetRound();
  }

  void _resetRound() {
    final base = <MatchItem>[
      const MatchItem(
        id: 'sun',
        word: 'SUN',
        icon: Icons.wb_sunny_rounded,
        color: Color(0xFFFFC107),
        asset: 'assets/images/sun.svg',
      ),
      const MatchItem(
        id: 'car',
        word: 'CAR',
        icon: Icons.directions_car_rounded,
        color: Color(0xFF29B6F6),
        asset: 'assets/images/car.svg',
      ),
      const MatchItem(
        id: 'cake',
        word: 'CAKE',
        icon: Icons.cake_rounded,
        color: Color(0xFFFF8A65),
        asset: 'assets/images/cake.svg',
      ),
      const MatchItem(
        id: 'star',
        word: 'STAR',
        icon: Icons.star_rounded,
        color: Color(0xFFFFD54F),
        asset: 'assets/images/star.svg',
      ),
      const MatchItem(
        id: 'book',
        word: 'BOOK',
        icon: Icons.menu_book_rounded,
        color: Color(0xFF81C784),
        asset: 'assets/images/book.svg',
      ),
      const MatchItem(
        id: 'flower',
        word: 'FLOWER',
        icon: Icons.local_florist_rounded,
        color: Color(0xFFF06292),
        asset: 'assets/images/flower.svg',
      ),
      const MatchItem(
        id: 'ball',
        word: 'BALL',
        icon: Icons.sports_soccer_rounded,
        color: Color(0xFF4FC3F7),
        asset: 'assets/images/ball.svg',
      ),
      const MatchItem(
        id: 'cat',
        word: 'CAT',
        icon: Icons.pets_rounded,
        color: Color(0xFFA1887F),
        asset: 'assets/images/cat.svg',
      ),
    ];

    base.shuffle();
    // Pick 6 each round for variety.
    final roundItems = base.take(6).toList();
    final icons = List<MatchItem>.from(roundItems)..shuffle();
    final words = List<MatchItem>.from(roundItems)..shuffle();

    setState(() {
      _items = icons;
      _words = words;
      _matched
        ..clear()
        ..addEntries(roundItems.map((e) => MapEntry(e.id, false)));
    });
  }

  int get _score => _matched.values.where((v) => v).length;
  int get _total => _matched.length;

  Future<void> _onAccept(MatchItem dragged, MatchItem target) async {
    final correct = dragged.id == target.id;
    if (correct) {
      HapticFeedback.lightImpact();
      setState(() => _matched[target.id] = true);
      if (_score == _total) {
        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;
        _showWinDialog();
      }
    } else {
      HapticFeedback.heavyImpact();
      // brief shake can be simulated by a snack or vibration; keep it simple.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Try again!'),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(milliseconds: 500),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7AE7FF), Color(0xFFB9FBC0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Great job!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'You matched all the words!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Play again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() => _round += 1);
                    _resetRound();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFFFF59D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    const Icon(Icons.extension_rounded, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Image-Word Match',
                      key: const Key('appTitle'),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Spacer(),
                    _ScorePill(score: _score, total: _total),
                    const SizedBox(width: 8),
                    Tooltip(
                      message: 'New round',
                      child: IconButton.filledTonal(
                        onPressed: () {
                          setState(() => _round += 1);
                          _resetRound();
                        },
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Drag the picture to the correct word',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Play area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 720;
                    final list = _buildPlayArea(isWide);
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: list,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayArea(bool isWide) {
    final left = _buildIconsPanel();
    final right = _buildWordsPanel();
    if (isWide) {
      return Row(
        key: ValueKey('wide-$_round'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: left),
          const VerticalDivider(width: 1, thickness: 1, color: Colors.black12),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      key: ValueKey('tall-$_round'),
      children: [
        Expanded(child: left),
        const Divider(height: 1, thickness: 1, color: Colors.black12),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildIconsPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _items.length,
        itemBuilder: (context, i) {
          final item = _items[i];
          final isDone = _matched[item.id] == true;
          return Draggable<MatchItem>(
            data: item,
            feedback: _IconCard(item: item, elevated: true, ghost: false),
            childWhenDragging: _IconCard(
              item: item,
              elevated: false,
              ghost: true,
            ),
            maxSimultaneousDrags: isDone ? 0 : 1,
            child: _IconCard(item: item, ghost: isDone, elevated: !isDone),
          );
        },
      ),
    );
  }

  Widget _buildWordsPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ListView.separated(
        itemCount: _words.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final wordItem = _words[i];
          final done = _matched[wordItem.id] == true;
          return DragTarget<MatchItem>(
            onWillAccept: (data) => (data?.id == wordItem.id) && !done,
            onAccept: (data) => _onAccept(data, wordItem),
            builder: (context, candidates, rejects) {
              final isHover = candidates.isNotEmpty;
              return _WordSlot(item: wordItem, isDone: done, isHover: isHover);
            },
          );
        },
      ),
    );
  }
}

class _IconCard extends StatelessWidget {
  final MatchItem item;
  final bool elevated;
  final bool ghost;

  const _IconCard({
    required this.item,
    this.elevated = true,
    this.ghost = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = item.color;
    final bg = ghost
        ? Colors.white.withOpacity(0.25)
        : LinearGradient(
            colors: [baseColor.withOpacity(0.95), baseColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: ghost ? 0.4 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: bg is Gradient ? bg : null,
          color: bg is Gradient ? null : bg as Color?,
          borderRadius: BorderRadius.circular(20),
          boxShadow: elevated
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: _buildPicture(item, size: 56, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPicture(MatchItem item, {double size = 48, Color? color}) {
    final asset = item.asset;
    if (asset != null) {
      return SvgPicture.asset(
        asset,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
        package: null,
      );
    }
    return Icon(item.icon, size: size, color: color);
  }
}

class _WordSlot extends StatelessWidget {
  final MatchItem item;
  final bool isDone;
  final bool isHover;

  const _WordSlot({
    required this.item,
    required this.isDone,
    required this.isHover,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = isDone
        ? LinearGradient(
            colors: [item.color.withOpacity(0.9), item.color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Colors.white.withOpacity(0.85),
              Colors.white.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 64,
      decoration: BoxDecoration(
        gradient: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isHover
              ? cs.primary
              : (isDone ? Colors.transparent : Colors.black12),
          width: isHover ? 3 : 1,
        ),
        boxShadow: isDone
            ? [
                BoxShadow(
                  color: item.color.withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isDone
                ? Colors.white
                : item.color.withOpacity(0.25),
            child: item.asset != null
                ? SvgPicture.asset(
                    item.asset!,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      isDone ? item.color : item.color.withOpacity(0.8),
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(
                    item.icon,
                    color: isDone ? item.color : item.color.withOpacity(0.8),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.word,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: isDone ? Colors.white : Colors.black87,
              ),
            ),
          ),
          AnimatedScale(
            scale: isDone ? 1 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.check_circle, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ScorePill extends StatelessWidget {
  final int score;
  final int total;
  const _ScorePill({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite_rounded, color: Colors.redAccent),
          const SizedBox(width: 6),
          Text(
            '$score / $total',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
