// lib/screens/palmistry_analysis_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart'; // <-- Импорт локализации
import 'package:lovequest/src/data/models/enums.dart';
import 'package:lovequest/src/data/models/palmistry_models.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';

class PalmistryAnalysisScreen extends StatefulWidget {
  const PalmistryAnalysisScreen({super.key});

  @override
  State<PalmistryAnalysisScreen> createState() => _PalmistryAnalysisScreenState();
}

class _PalmistryAnalysisScreenState extends State<PalmistryAnalysisScreen> with TickerProviderStateMixin {
  final Map<String, String> _userChoices = {};
  List<String> _linesToScan = [];
  int _currentScanIndex = -1;
  bool _showHotspot = false;
  late AnimationController _lineAnimationController;
  late Animation<double> _lineAnimation;

  final Map<String, List<Offset>> _linePoints = {
    'heart_line': [const Offset(0.68, 0.52), const Offset(0.55, 0.49), const Offset(0.45, 0.43)],
    'head_line':  [const Offset(0.65, 0.58), const Offset(0.51, 0.52), const Offset(0.33, 0.47)],
    'life_line':  [const Offset(0.36, 0.48), const Offset(0.48, 0.57), const Offset(0.41, 0.69)],
    'fate_line':  [const Offset(0.52, 0.64), const Offset(0.52, 0.53), const Offset(0.51, 0.42)],
  };

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  void _initializeScreen() async {
    _lineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _lineAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if(mounted) setState(() { _showHotspot = true; });
      }
    });
    _lineAnimation = CurvedAnimation(parent: _lineAnimationController, curve: Curves.easeInOut);

    await context.read<AppCubit>().loadPalmistryData();
    if (mounted) {
      final palmData = context.read<AppCubit>().state.palmistryData;
      if (palmData != null) {
        setState(() {
          _linesToScan = ['heart_line', 'head_line', 'life_line', 'fate_line'];
          _startNextScan();
        });
      }
    }
  }

  void _startNextScan() {
    if (_currentScanIndex >= _linesToScan.length - 1) {
      if(mounted) setState(() { _currentScanIndex++; });
      return;
    }
    if(mounted) {
      setState(() {
        _currentScanIndex++;
        _showHotspot = false;
        _lineAnimationController.reset();
        _lineAnimationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _lineAnimationController.dispose();
    super.dispose();
  }

  void _showOptionsDialog(BuildContext context, String lineKey, PalmLine lineData) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builderContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6, minChildSize: 0.4, maxChildSize: 0.9,
          builder: (_, scrollController) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1e1b34).withOpacity(0.95),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 20),
                  Text(lineData.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                  const SizedBox(height: 8),
                  Text(lineData.description, style: const TextStyle(color: Colors.white70)),
                  const Divider(height: 30, color: Colors.white24),
                  Text(l10n.palmistry_choose_option, style: const TextStyle(fontWeight: FontWeight.bold)), // "Выберите вариант"
                  const SizedBox(height: 10),
                  ...lineData.options.entries.map((entry) {
                    return RadioListTile<String>(
                      title: Text(entry.value.choiceText),
                      value: entry.key,
                      groupValue: _userChoices[lineKey],
                      onChanged: (value) {
                        setState(() { _userChoices[lineKey] = value!; });
                        Navigator.of(builderContext).pop();
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      if (_userChoices.containsKey(lineKey)) {
        _startNextScan();
      }
    });
  }

  void _saveResults() {
    final l10n = AppLocalizations.of(context)!;
    context.read<AppCubit>().savePalmistryResults(_userChoices);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.palmistry_analysis_saved))); // "Анализ сохранен!"
    context.pushReplacement('/palmistry_report');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.palmistry_analysis_title), // "Анализ Ладони"
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedCosmicBackground(
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if (state.palmistryLoadingState != LoadingState.success || state.palmistryData == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final palmData = state.palmistryData!;
              final allLinesAnalyzed = _linesToScan.every((key) => _userChoices.containsKey(key));
              final String? currentLineKey = _currentScanIndex < _linesToScan.length ? _linesToScan[_currentScanIndex] : null;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          _buildInstructionText(currentLineKey, palmData, allLinesAnalyzed, l10n),
                          const SizedBox(height: 20),

                          InteractiveViewer(
                            minScale: 1.0,
                            maxScale: 3.0,
                            child: Builder(
                                builder: (context) {
                                  final imageWidth = MediaQuery.of(context).size.width * 0.9;
                                  final imageHeight = imageWidth * (450.0 / 350.0);
                                  final imageSize = Size(imageWidth, imageHeight);

                                  return SizedBox(
                                    width: imageWidth,
                                    height: imageHeight,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset('assets/images/palm_guide.png', fit: BoxFit.contain),
                                        CustomPaint(
                                          size: imageSize,
                                          painter: LinesPainter(
                                            animation: _lineAnimation,
                                            currentLineKey: currentLineKey,
                                            completedLines: _userChoices.keys.toSet(),
                                            linePoints: _linePoints,
                                          ),
                                        ),
                                        if (_showHotspot && currentLineKey != null)
                                          ..._buildHotspots(imageSize, palmData),
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => SizeTransition(sizeFactor: animation, child: child),
                            child: (currentLineKey != null && _showHotspot && !allLinesAnalyzed)
                                ? _buildInteractiveButtons(context, currentLineKey, palmData.lines[currentLineKey]!)
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  _buildAnalysisControls(allLinesAnalyzed, l10n),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisControls(bool allLinesAnalyzed, AppLocalizations l10n) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: allLinesAnalyzed ? Colors.pinkAccent : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: allLinesAnalyzed ? _saveResults : null,
        child: Text(allLinesAnalyzed ? l10n.palmistry_view_report : l10n.palmistry_complete_all), // "Посмотреть полный отчет" / "Завершите анализ..."
      ),
    );
  }

  Widget _buildInteractiveButtons(BuildContext context, String lineKey, PalmLine lineData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        key: ValueKey(lineKey),
        children: [
          Text(lineData.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            child: ListView(
              shrinkWrap: true,
              children: lineData.options.entries.map((entry) {
                final isSelected = _userChoices[lineKey] == entry.key;
                return Card(
                  color: isSelected ? Colors.green.withOpacity(0.3) : Colors.white.withOpacity(0.1),
                  child: ListTile(
                    title: Text(entry.value.choiceText, style: const TextStyle(fontSize: 14)),
                    dense: true,
                    leading: Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
                    onTap: () {
                      setState(() {
                        _userChoices[lineKey] = entry.key;
                      });
                      _startNextScan();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHotspots(Size size, PalmistryData palmData) {
    final Map<String, Offset> hotspotPositions = {
      'heart_line': Offset(size.width * 0.75, size.height * 0.35),
      'head_line':  Offset(size.width * 0.72, size.height * 0.48),
      'life_line':  Offset(size.width * 0.55, size.height * 0.75),
      'fate_line':  Offset(size.width * 0.70, size.height * 0.60),
    };

    final currentLineKey = _currentScanIndex < _linesToScan.length ? _linesToScan[_currentScanIndex] : null;

    if (currentLineKey == null || !hotspotPositions.containsKey(currentLineKey)) {
      return [];
    }

    final position = hotspotPositions[currentLineKey]!;

    return [
      Positioned(
        top: position.dy,
        left: position.dx,
        child: Transform.translate(
          offset: const Offset(-45, -22),
          child: _buildLineHotspot(
            lineKey: currentLineKey,
            lineData: palmData.lines[currentLineKey]!,
          ),
        ),
      )
    ];
  }

  Widget _buildInstructionText(String? currentLineKey, PalmistryData palmData, bool allAnalyzed, AppLocalizations l10n) {
    String text;
    if (allAnalyzed) {
      text = l10n.palmistry_analysis_complete; // "Отлично! Анализ завершен."
    } else if (currentLineKey != null) {
      if (_showHotspot) {
        text = l10n.palmistry_tap_line(palmData.lines[currentLineKey]!.title); // "Нажмите на '{title}'..."
      } else {
        text = l10n.palmistry_searching_line(palmData.lines[currentLineKey]!.title); // "Идет поиск '{title}'..."
      }
    } else {
      text = l10n.palmistry_preparing; // "Подготовка к анализу..."
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Text(text, key: ValueKey(text), style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildLineHotspot({required String lineKey, required PalmLine lineData}) {
    return GestureDetector(
      onTap: () => _showOptionsDialog(context, lineKey, lineData),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.9, end: 1.0),
        duration: const Duration(seconds: 1),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade600, Colors.blue.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.cyan.withOpacity(0.7),
                  blurRadius: 12,
                  spreadRadius: 1
              )
            ],
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                lineData.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.touch_app, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Animation<double> animation;
  final String? currentLineKey;
  final Set<String> completedLines;
  final Map<String, List<Offset>> linePoints;

  LinesPainter({
    required this.animation,
    this.currentLineKey,
    required this.completedLines,
    required this.linePoints,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final completedPaint = Paint()
      ..color = Colors.greenAccent.withOpacity(0.8)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.0);

    final currentPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(animation.value)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    for (var lineKey in completedLines) {
      if (lineKey != currentLineKey) {
        canvas.drawPath(_getPathForKey(lineKey, size), completedPaint);
      }
    }

    if (currentLineKey != null) {
      final paintToUse = completedLines.contains(currentLineKey) ? completedPaint : currentPaint;
      canvas.drawPath(_getPathForKey(currentLineKey!, size), paintToUse);
    }
  }

  Path _getPathForKey(String lineKey, Size size) {
    final Path path = Path();
    final points = linePoints[lineKey]!;
    path.moveTo(points[0].dx * size.width, points[0].dy * size.height);
    path.quadraticBezierTo(
      points[1].dx * size.width, points[1].dy * size.height,
      points[2].dx * size.width, points[2].dy * size.height,
    );
    return path;
  }

  @override
  bool shouldRepaint(covariant LinesPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.currentLineKey != currentLineKey ||
        !setEquals(oldDelegate.completedLines, completedLines); // Исправлено сравнение
  }
}