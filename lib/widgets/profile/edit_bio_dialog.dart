// lib/widgets/profile/edit_bio_dialog.dart
import 'package:flutter/material.dart';

class EditBioDialog extends StatefulWidget {
  final String currentBio;
  final Function(String) onSave;

  const EditBioDialog({
    super.key,
    required this.currentBio,
    required this.onSave,
  });

  @override
  State<EditBioDialog> createState() => _EditBioDialogState();
}

class _EditBioDialogState extends State<EditBioDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentBio);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('О себе'),
      content: TextField(
        controller: _controller,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Расскажите о себе и своих увлечениях...',
          hintText: 'Например: Увлекаюсь #астрология и #йога',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () {
            widget.onSave(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}