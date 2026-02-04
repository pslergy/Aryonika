import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lovequest/src/data/models/tarot_card.dart';

class FlippableTarotCard extends StatefulWidget {
  final TarotCard card;
  final bool isFlipped;
  final VoidCallback onCardFlip;

  // Эти параметры оставляем, но они будут работать как "желаемые" пропорции,
  // если родитель не накладывает ограничений.
  final double? width;
  final double? height;

  const FlippableTarotCard({
    super.key,
    required this.card,
    required this.isFlipped,
    required this.onCardFlip,
    this.width,
    this.height,
  });

  @override
  State<FlippableTarotCard> createState() => _FlippableTarotCardState();
}

class _FlippableTarotCardState extends State<FlippableTarotCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);

    if (widget.isFlipped) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FlippableTarotCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      widget.isFlipped ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Обрабатываем нажатие только если карта закрыта
          if (!widget.isFlipped) {
            widget.onCardFlip();
          }
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * -pi;

            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle);

            // Убрали SizedBox отсюда. Теперь размер определяет родитель (AspectRatio).
            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: _animation.value >= 0.5 ? _buildFront() : _buildBack(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront() {
    Widget imageWidget = Image(
      image: widget.card.image,
      fit: BoxFit.cover, // Картинка заполняет всё пространство
    );

    if (widget.card.isReversed) {
      imageWidget = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(pi),
        child: imageWidget,
      );
    }

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        // Используем width/height если переданы, иначе занимаем всё место
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imageWidget,
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/tarot/tarot_card_back.jpg',
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => const Center(
              child: Icon(Icons.auto_awesome, color: Colors.amber)),
        ),
      ),
    );
  }
}