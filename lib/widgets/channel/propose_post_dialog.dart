// lib/widgets/channel/propose_post_dialog.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/cubit/channel_cubit.dart';

class ProposePostDialog extends StatefulWidget {

  const ProposePostDialog({super.key});

  @override
  State<ProposePostDialog> createState() => _ProposePostDialogState();
}

class _ProposePostDialogState extends State<ProposePostDialog> {
  final _textController = TextEditingController();
  bool _isLoading = false;
  String? _imageBase64;
  XFile? _imageFile;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 1080);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _imageFile = file;
        _imageBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _submit() async {
    if (_textController.text.trim().isEmpty && _imageBase64 == null) {
      // Не даем отправить пустой пост
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте текст или изображение.')),
      );
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // --- 👇 3. ИСПРАВЬ ВЫЗОВ МЕТОДА КУБИТА 👇 ---
      // channelId больше не передается, кубит знает его сам.
      await context.read<ChannelCubit>().proposePost(
        _textController.text.trim(),
        imageFile: _imageFile,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ваш пост отправлен на модерацию!')),
        );
      }
    } catch (e) {
      setState(() { _isLoading = false; });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Предложить новость'),
      content: SingleChildScrollView( // <-- Оборачиваем в скролл
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- НОВОЕ: превью картинки ---
            if (_imageFile != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(_imageFile!.path, height: 150, fit: BoxFit.cover),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => setState(() { _imageFile = null; _imageBase64 = null; }),
                  )
                ],
              ),
            const SizedBox(height: 8),

            TextField(
              controller: _textController,
              autofocus: true,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Введите текст вашего поста...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // --- НОВАЯ КНОПКА: "Прикрепить фото" ---
        IconButton(
          onPressed: _isLoading ? null : _pickImage,
          icon: const Icon(Icons.add_photo_alternate_outlined),
          tooltip: 'Прикрепить фото',
        ),
        const Spacer(),
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Отправить'),
        ),
      ],
    );
  }
}