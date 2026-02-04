// lib/widgets/channel/create_post_dialog.dart

import 'dart:io'; // Нужен для работы с классом File
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/cubit/channel_cubit.dart';


import 'package:lovequest/l10n/generated/app_localizations.dart';
import '../../services/logger_service.dart';


class CreatePostDialog extends StatefulWidget {

  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  // --- Храним объект XFile, который возвращает image_picker ---
  XFile? _imageFile;

  // Локальное состояние для управления UI
  bool _isPickingImage = false;
  bool _isSubmitting = false;

  // Переменные для хранения размеров изображения
  double? _imageWidth;
  double? _imageHeight;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Открывает галерею, позволяет пользователю выбрать изображение
  /// и сохраняет его в локальное состояние для превью и последующей загрузки.
  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    setState(() => _isPickingImage = true);

    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Оптимальное качество для веба
        maxWidth: 1920,   // Ограничиваем размер, чтобы не грузить огромные фото
      );

      if (file == null) {
        // Пользователь закрыл галерею, ничего не выбрав
        setState(() => _isPickingImage = false);
        return;
      }

      // Читаем байты файла, чтобы определить его размеры
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);

      // Обновляем состояние, чтобы показать превью
      setState(() {
        _imageFile = file; // Сохраняем сам объект файла
        _imageWidth = image.width.toDouble();
        _imageHeight = image.height.toDouble();
        _isPickingImage = false;
      });

    } catch (e) {
      logger.d("!!! CreatePostDialog ОШИБКА: Не удалось выбрать или обработать изображение. $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ошибка при выборе изображения"), backgroundColor: Colors.red),
        );
      }
      setState(() => _isPickingImage = false);
    }
  }

  /// Удаляет выбранное изображение из состояния.
  void _removeImage() {
    setState(() {
      _imageFile = null;
      _imageWidth = null;
      _imageHeight = null;
    });
  }

  /// Валидирует форму и отправляет данные в ChannelCubit для создания поста.
  Future<void> _submitPost() async {
    final l10n = AppLocalizations.of(context)!;
    if (_isSubmitting) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);

    // --- 👇 ВОТ ИСПРАВЛЕНИЕ 👇 ---
    // 1. Сохраняем ScaffoldMessenger и Navigator В ПЕРЕМЕННЫЕ, пока context "живой".
    // Мы используем `if (mounted)` для безопасности, чтобы убедиться, что виджет все еще на экране.
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context); // Используем GoRouter, если он у тебя есть, или Navigator.of(context)

    // 2. Сначала вызываем метод кубита. Он начнет работу в фоне.
    context.read<ChannelCubit>().createPost(
      // Убираем channelId: widget.channelId,
      text: _textController.text.trim(),
      imageFile: _imageFile,
      anonymousAuthorName: l10n.channelAnonymousAuthor,
    );

    // 3. Сразу закрываем диалог.
    // С этого момента старый 'context' использовать нельзя!
    if (mounted) navigator.pop();

    // 4. Показываем SnackBar, используя сохраненную переменную.
    // Это теперь безопасно, так как мы обращаемся к Scaffold'у родительского экрана.
    scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Публикуем ваш пост... Это может занять некоторое время."))
    );
    // --- 👆 КОНЕЦ ИСПРАВЛЕНИЯ 👆 ---
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создать публикацию'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _textController,
                maxLines: 5,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Что у вас нового?',
                  labelText: 'Текст поста',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Пост не может быть пустым, только если к нему не прикреплена картинка
                  if ((value == null || value.trim().isEmpty) && _imageFile == null) {
                    return 'Пост не может быть пустым';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Блок для превью или добавления изображения
              if (_imageFile != null)
              // Если картинка выбрана, показываем ее превью
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      // Image.file идеально подходит для отображения локальных файлов
                      child: Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _removeImage,
                      icon: const Icon(Icons.close, color: Colors.redAccent),
                      label: const Text('Удалить фото', style: TextStyle(color: Colors.redAccent)),
                    )
                  ],
                )
              else
              // Если картинки нет, показываем кнопку добавления
                OutlinedButton.icon(
                  onPressed: _isPickingImage ? null : _pickImage,
                  icon: _isPickingImage
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Добавить фото'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => context.pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _submitPost,
          child: _isSubmitting
              ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Опубликовать'),
        ),
      ],
    );
  }
}