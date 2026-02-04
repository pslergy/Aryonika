// lib/widgets/oracle/oracle_question_section.dart
import 'package:flutter/material.dart';

class OracleQuestionSection extends StatefulWidget {
  const OracleQuestionSection({super.key});

  @override
  State<OracleQuestionSection> createState() => _OracleQuestionSectionState();
}

class _OracleQuestionSectionState extends State<OracleQuestionSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Подключить к BlocBuilder для получения oracleAnswer и isAnswering
    final bool isAnswering = false;
    final String? oracleAnswer = null;

    if (isAnswering) {
      return const Center(child: CircularProgressIndicator()); // Просто для примера
    }

    if (oracleAnswer != null) {
      return Column(children: [
        Text(oracleAnswer, style: const TextStyle(color: Colors.white70)),
        TextButton(onPressed: (){ /* TODO: cubit.resetOracle() */ }, child: const Text("Спросить еще раз"))
      ]);
    }

    return Column(
      children: [
        TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Задайте свой вопрос Оракулу...',
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              // TODO: context.read<AppCubit>().askOracle(_controller.text);
            }
          },
          child: const Text('Получить ответ'),
        ),
      ],
    );
  }
}