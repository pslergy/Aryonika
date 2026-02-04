// lib/screens/channel_settings_screen.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/cubit/app_state.dart';
import 'package:lovequest/widgets/common/animated_cosmic_background.dart';
import 'package:lovequest/widgets/common/neon_glow_button.dart';

import '../cubit/channel_cubit.dart';
import '../cubit/channel_state.dart';

class ChannelSettingsScreen extends StatefulWidget {
  // 1. Объявляем поле для хранения ID
  final String channelId;

  // 2. Добавляем его в конструктор как обязательный именованный параметр
  const ChannelSettingsScreen({super.key, required this.channelId});

  @override
  State<ChannelSettingsScreen> createState() => _ChannelSettingsScreenState();
}

class _ChannelSettingsScreenState extends State<ChannelSettingsScreen> {
  late final TextEditingController _descriptionController;


  // --- ИЗМЕНЕНИЕ: Получаем ChannelCubit ---
  late final ChannelCubit _channelCubit;
  final ValueNotifier<bool> _isSavingDescription = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    // === ВОТ ИСПРАВЛЕНИЕ ===
    // Получаем ChannelCubit из контекста и сохраняем его в переменную.
    // Теперь _channelCubit инициализирован и готов к использованию.
    _channelCubit = context.read<ChannelCubit>();

    // Эта часть кода остается без изменений
    final initialDescription = _channelCubit.state.activeChannel?.getLocalizedDescription('ru') ?? '';
    _descriptionController = TextEditingController(text: initialDescription);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (file != null) {
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);

      // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
      // Вызываем метод БЕЗ channelId
      await context.read<ChannelCubit>().updateChannelAvatar(base64String);

      if (mounted) {
        // Так как метод больше не возвращает bool, мы просто показываем SnackBar
        // после успешного выполнения
        context.read<AppCubit>().onChannelsTabOpened();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Аватар обновлен")));
      }
      // --- КОНЕЦ ИСПРАВЛЕНИЯ ---
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedCosmicBackground(
          // --- 👇 ГЛАВНОЕ ИЗМЕНЕНИЕ: ОБОРАЧИВАЕМ ВСЕ В BlocListener 👇 ---
          child: BlocListener<ChannelCubit, ChannelState>(
            listener: (context, state) {
              // Если есть сообщение об успехе, показываем зеленый SnackBar
              if (state.successMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.successMessage!), backgroundColor: Colors.green[700]),
                );
                // Сбрасываем сообщение в кубите, чтобы оно не показалось снова
                context.read<ChannelCubit>().clearMessages();
              }
              // Если есть сообщение об ошибке, показываем красный SnackBar
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red[700]),
                );
                context.read<ChannelCubit>().clearMessages();
              }
            },
            child: BlocBuilder<ChannelCubit, ChannelState>(
              builder: (context, state) {
                final channel = state.activeChannel;

                if (channel == null || state.activeChannelStatus == ChannelStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ... (твой код для imageUrl и imageBytes остается без изменений)
                final imageUrl = channel.avatarUrl;
                final imageBytes = (imageUrl != null && imageUrl.isNotEmpty && imageUrl.contains(','))
                    ? base64Decode(imageUrl.split(',').last)
                    : null;

                return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  title: const Text("Настройки канала"),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Растягиваем кнопки по ширине
                      children: [
                        // --- Секция Аватара ---
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: imageBytes != null ? MemoryImage(imageBytes) : null,
                                child: imageBytes == null ? const Icon(Icons.public, size: 60) : null,
                              ),
                              Positioned(
                                bottom: 0, right: 0,
                                child: IconButton.filled(
                                  icon: const Icon(Icons.edit),
                                  onPressed: _pickImage,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- Секция Описания ---
                        const Text("Описание", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Расскажите о вашем канале...',
                          ),
                        ),
                        const SizedBox(height: 8),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isSavingDescription,
                          builder: (context, isLoading, child) {
                            return ElevatedButton(
                              onPressed: isLoading ? null : () async {
                                _isSavingDescription.value = true;

                                // --- 👇 ВОТ ИСПРАВЛЕНИЕ 👇 ---
                                // Получаем langCode прямо здесь, из контекста
                                final langCode = context.read<AppCubit>().currentLocale.languageCode;

                                // Передаем объект с ключом langCode
                                await _channelCubit.updateChannelDescription({langCode: _descriptionController.text});

                                if(mounted) {
                                  context.read<AppCubit>().onChannelsTabOpened();
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Описание сохранено")));
                                }
                                _isSavingDescription.value = false;
                              },
                              child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text("Сохранить описание"),
                            );
                          },
                        ),
                        const Divider(height: 48),
                        // === НОВАЯ СЕКЦИЯ: Авторство постов ===
                        const Text("Авторство постов", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text(
                          "Выберите, от чьего имени будут публиковаться посты, созданные вами.",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(value: 'owner', label: Text('От себя')),
                            ButtonSegment(value: 'channel', label: Text('От канала')),
                            ButtonSegment(value: 'anonymous', label: Text('Анонимно')),
                          ],
                          selected: {channel.postAuthorship},
                          onSelectionChanged: (newSelection) {
                            // Вызываем метод из ChannelCubit для обновления
                            context.read<ChannelCubit>().updateAuthorship(newSelection.first);
                          },
                        ),

                        const Divider(height: 48),

                        // --- Секция Приватности ---
                        const Text("Приватность", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SwitchListTile(
                          title: const Text("Приватный канал"),
                          subtitle: Text(channel.isPrivate ? "Вступление только по приглашению" : "Открыт для всех"),
                          value: channel.isPrivate,
                          onChanged: (_) => context.read<ChannelCubit>().toggleChannelPrivacy(),
                        ),
                        if (channel.isPrivate && channel.inviteKey != null)
                          ListTile(
                            title: const Text("Ключ-приглашение"),
                            subtitle: Text(channel.inviteKey!),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: channel.inviteKey!));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ключ скопирован!")));
                              },
                            ),
                          ),
                        const Divider(height: 48),

                        // --- Секция Управления ---
                        const Text("Управление", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ListTile(
                          leading: const Icon(Icons.pending_actions_rounded),
                          title: const Text("Предложенные посты"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            context.push('/channel-moderation/${channel.id}');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.block),
                          title: const Text("Заблокированные пользователи"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: Реализовать экран/диалог со списком забаненных
                            // и возможностью разбанить.
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Функция в разработке")));
                          },
                        ),
                        const Divider(height: 48),

                        // --- Опасная зона ---
                        Center(
                          child: NeonGlowButton(
                            text: "Удалить канал",
                            glowColor: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text("Удалить канал?"),
                                  content: const Text("Это действие нельзя будет отменить. Все посты и комментарии будут удалены навсегда."),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text("Отмена")),
                                    FilledButton(
                                      style: FilledButton.styleFrom(backgroundColor: Colors.red),
                                      onPressed: () {
                                        _channelCubit.deleteChannel().then((_) {
                                          if (mounted) {
                                            // Используем `go`, чтобы очистить стек навигации
                                            context.push('/channels');
                                          }
                                        });
                                      },
                                      child: const Text("Удалить"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
        )
    );
  }
}