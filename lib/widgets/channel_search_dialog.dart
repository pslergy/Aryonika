// lib/widgets/channel/channel_search_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovequest/cubit/app_cubit.dart';
import 'package:lovequest/l10n/generated/app_localizations.dart';
import 'package:lovequest/src/data/models/channel.dart'; // Убедись, что импорт модели правильный
import 'common/glassmorphic_card.dart';

class ChannelSearchDialog extends StatefulWidget {
  const ChannelSearchDialog({super.key});

  @override
  State<ChannelSearchDialog> createState() => _ChannelSearchDialogState();
}

class _ChannelSearchDialogState extends State<ChannelSearchDialog> {
  // Используем типизированный список, если возможно (List<Channel>)
  // Если AppCubit возвращает dynamic, оставляем dynamic, но лучше Channel
  List<dynamic> _results = [];
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Запускаем пустой поиск, чтобы получить рекомендации от бэкенда
    _search('');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    setState(() => _isLoading = true);

    // Предполагаем, что searchChannels возвращает List<Channel>
    final results = await context.read<AppCubit>().searchChannels(query);

    if (!mounted) return; // Защита от асинхронных ошибок

    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Получаем текущий язык приложения
    final langCode = Localizations.localeOf(context).languageCode;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: GlassmorphicCard(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  l10n.channelSearchTitle,
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),

              // Стилизованное поле ввода
              TextField(
                controller: _controller,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: l10n.searchHint, // Добавь этот ключ в l10n или напиши 'Поиск...'
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onSubmitted: _search,
                textInputAction: TextInputAction.search,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : _results.isEmpty
                    ? Center(
                    child: Text(
                        "Ничего не найдено",
                        style: TextStyle(color: Colors.white.withOpacity(0.5))
                    )
                )
                    : ListView.separated(
                  shrinkWrap: true,
                  itemCount: _results.length,
                  separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.1)),
                  itemBuilder: (context, index) {
                    final channel = _results[index]; // Это объект Channel

                    return ListTile(
                      title: Text(
                        // Используем метод модели для получения локализованного имени
                        channel.getLocalizedName(langCode),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '@${channel.handle} • ${channel.subscriberCount} subs',
                        style: TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white10,
                        backgroundImage: (channel.avatarUrl != null && channel.avatarUrl!.isNotEmpty)
                            ? NetworkImage(channel.avatarUrl!)
                            : null,
                        child: (channel.avatarUrl == null || channel.avatarUrl!.isEmpty)
                            ? Text(
                            channel.getLocalizedName('en').substring(0, 1).toUpperCase(),
                            style: const TextStyle(color: Colors.white)
                        )
                            : null,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                      onTap: () {
                        Navigator.of(context).pop(channel.id.toString());
                        context.push('/channel-details/${channel.id}');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}