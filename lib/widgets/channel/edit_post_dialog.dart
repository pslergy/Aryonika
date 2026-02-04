// lib/widgets/channel/edit_post_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovequest/cubit/channel_cubit.dart';
import 'package:lovequest/src/data/models/post.dart';

class EditPostDialog extends StatefulWidget {
  final Post post;
  const EditPostDialog({super.key, required this.post});

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  late final TextEditingController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.post.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isLoading = true);

    await context.read<ChannelCubit>().editPost(widget.post.id, _controller.text.trim());

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Редактировать пост"),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: null, // Позволяет вводить многострочный текст
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(hintText: "Введите новый текст"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Отмена"),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Сохранить"),
        ),
      ],
    );
  }
}