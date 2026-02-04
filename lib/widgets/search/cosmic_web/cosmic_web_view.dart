// lib/widgets/search/cosmic_web/cosmic_web_view.dart

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';

import 'package:lovequest/widgets/search/cosmic_web/cosmic_web_user_node.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../services/logger_service.dart';
import 'cosmic_web_painter.dart';

class CosmicWebView extends StatefulWidget {
  const CosmicWebView({super.key});

  @override
  State<CosmicWebView> createState() => _CosmicWebViewState();
}

class _CosmicWebViewState extends State<CosmicWebView> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  final TransformationController _transformationController = TransformationController();

  Object _state = "loading";
  // --- НАЧАЛО ИЗМЕНЕНИЙ ---
  // Вместо String? _errorText храним саму ошибку
  Object? _errorObject;
  // --- КОНЕЦ ИЗМЕНЕНИЙ ---
  List<CosmicWebUserNode> _allNodes = [];
  Size _canvasSize = Size.zero;

  final Map<String, ui.Image> _loadedAvatars = {};

  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) { // Добавим проверку, что виджет еще "жив"
        _initialize();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _transformationController.dispose();
    _loadedAvatars.values.forEach((img) => img.dispose());
    _loadedAvatars.clear();
    super.dispose();
  }

  Future<void> _initialize() async {
    try {
      if (!mounted) return;
      setState(() { _state = "loading"; });

      final cubit = context.read<AppCubit>();
      final rawUsers = await cubit.fetchCosmicWebUsers(
        gender: cubit.state.genderFilter,
        minAge: cubit.state.minAgeFilter,
        maxAge: cubit.state.maxAgeFilter,
      );

      // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ: ДИНАМИЧЕСКИЙ РАСЧЕТ 👇 ---
      // 1. Вызываем новую функцию, которая возвращает и ноды, и размер
      final calculationResult = _calculateNodePositionsAndSize(rawUsers);

      _allNodes = calculationResult.$1;
      _canvasSize = calculationResult.$2;

      final screenSize = MediaQuery.of(context).size;

      // Если пользователей нет, установим размер холста равным размеру экрана
      if (_canvasSize == Size.zero) {
        _canvasSize = screenSize;
      }
      // --- 👆 КОНЕЦ ИЗМЕНЕНИЯ 👆 ---

      _loadAvatars();

      // Центрируем камеру на созданном мире
      final initialOffset = Offset(
        -(_canvasSize.width / 2) + (screenSize.width / 2),
        -(_canvasSize.height / 2) + (screenSize.height / 2),
      );
      const initialScale = 0.5;
      final initialMatrix = Matrix4.identity()
        ..translate(initialOffset.dx, initialOffset.dy)
        ..scale(initialScale);
      _transformationController.value = initialMatrix;

      if (!mounted) return;
      setState(() { _state = "success"; });

    } catch (e) {
      if (mounted) {
        // --- НАЧАЛО ИЗМЕНЕНИЙ ---
        // Сохраняем объект ошибки, а не текст
        setState(() { _state = "error"; _errorObject = e; });
        // --- КОНЕЦ ИЗМЕНЕНИЙ ---
      }
    }
  }

  void _handleTap(TapUpDetails details) {
    final screenTapPosition = details.localPosition;
    final worldTapPosition = _transformationController.toScene(screenTapPosition);

    for (final node in _allNodes.reversed) {
      if ((worldTapPosition - node.position).distance <= node.radius) {
        logger.d("Нажатие на пользователя: ${node.user.name}");
        context.push('/user_profile/${node.user.id}');
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_state == "loading") return const Center(child: CircularProgressIndicator());

    // --- НАЧАЛО ИЗМЕНЕНИЙ ---
    // Формируем текст ошибки прямо здесь, используя l10n
    if (_state == "error") {
      final errorText = "${l10n.errorFailedToLoadData}:\n${_errorObject.toString()}";
      return Center(child: Text(errorText, textAlign: TextAlign.center));
    }

    return GestureDetector(
      onTapUp: _handleTap,
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 0.1,
        maxScale: 5.0,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: CustomPaint(
          size: _canvasSize,
          painter: CosmicWebPainter(
            nodes: _allNodes,
            pulseAnimation: _pulseController,
            loadedAvatars: _loadedAvatars,
          ),
        ),
      ),
    );
  }

  // --- Вспомогательные методы ---

  // --- 👇 ИЗМЕНЕННАЯ ФУНКЦИЯ ДЛЯ РАСЧЕТА ПОЗИЦИЙ И РАЗМЕРА 👇 ---
  (List<CosmicWebUserNode>, Size) _calculateNodePositionsAndSize(List<CosmicWebUser> users) {
    final List<CosmicWebUserNode> nodes = [];
    final random = Random();

    if (users.isEmpty) {
      return ([], Size.zero);
    }

    const double hexRadius = 80.0;
    final double hexWidth = hexRadius * 2;
    final double hexHeight = sqrt(3) * hexRadius;

    final int cols = (sqrt(users.length) * 1.2).ceil().clamp(1, 1000);
    final int rows = (users.length / cols).ceil();

    final List<Offset> cellPositions = [];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final double x = col * hexWidth * 0.75;
        final double y = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);
        cellPositions.add(Offset(x, y));
      }
    }
    cellPositions.shuffle(random);

    double maxX = 0;
    double maxY = 0;
    if (cellPositions.isNotEmpty) {
      maxX = cellPositions.map((p) => p.dx).reduce(max) + hexWidth;
      maxY = cellPositions.map((p) => p.dy).reduce(max) + hexHeight;
    }
    final calculatedSize = Size(maxX + 200, maxY + 200); // Отступы

    for (int i = 0; i < users.length && i < cellPositions.length; i++) {
      final user = users[i];
      final position = cellPositions[i];
      final radius = 20.0 + (user.compatibilityScore / 100.0) * 25.0;

      ImageProvider? provider;
      final urlOrAsset = user.avatarUrl;
      if (urlOrAsset != null && urlOrAsset.isNotEmpty) {
        if (urlOrAsset.startsWith('http')) {
          provider = NetworkImage(urlOrAsset);
        } else {
          provider = AssetImage('assets/images/$urlOrAsset.png');
        }
      }

      // Добавляем отступ, чтобы мир не начинался с 0,0
      nodes.add(CosmicWebUserNode(user: user, position: position.translate(100, 100), radius: radius, avatarProvider: provider));
    }

    return (nodes, calculatedSize);
  }

  Future<void> _loadAvatars() async {
    for (final node in _allNodes) {
      if (node.avatarProvider != null && !_loadedAvatars.containsKey(node.user.id)) {
        final completer = Completer<ui.Image>();
        final listener = ImageStreamListener(
              (info, _) {
            if (!completer.isCompleted) completer.complete(info.image);
          },
          onError: (exception, stackTrace) {
            if (!completer.isCompleted) {
              logger.d("Ошибка загрузки аватара для ${node.user.name}: $exception");
              completer.completeError(exception);
            }
          },
        );

        final stream = node.avatarProvider!.resolve(const ImageConfiguration());
        stream.addListener(listener);

        try {
          final image = await completer.future;
          if (mounted) {
            setState(() { _loadedAvatars[node.user.id] = image; });
          }
        } catch (e) {
          // Ошибка уже залогирована
        } finally {
          stream.removeListener(listener);
        }
      }
    }
  }
}