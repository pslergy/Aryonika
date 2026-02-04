// lib/widgets/common/alpha_version_banner.dart

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';
import '../../services/logger_service.dart';
// <-- ИМПОРТ

class AlphaVersionBanner extends StatefulWidget {
  final String telegramChannelUrl;
  final bool initiallyExpanded;

  const AlphaVersionBanner({
    super.key,
    required this.telegramChannelUrl,
    this.initiallyExpanded = false, // По умолчанию баннер свернут
  });

  @override
  State<AlphaVersionBanner> createState() => _AlphaVersionBannerState();
}

class _AlphaVersionBannerState extends State<AlphaVersionBanner> {
  // Состояние для отслеживания, свернут ли баннер
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Future<void> _launchTelegramChannel() async {
    final uri = Uri.parse(widget.telegramChannelUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      logger.d('Could not launch ${widget.telegramChannelUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Оборачиваем все в Card для красивого вида
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.deepPurple.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.deepPurple.shade300, width: 1),
      ),
      clipBehavior: Clip.antiAlias, // Чтобы ExpansionTile не вылезал за рамки
      child: Theme(
        // Убираем разделители сверху и снизу у ExpansionTile
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // Состояние контролируется виджетом
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (isExpanding) {
            setState(() {
              _isExpanded = isExpanding;
            });
          },
          // Заголовок - то, что видно всегда
          title: Row(
            children: [
              const Icon(Icons.science_outlined, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.alphaBannerTitle, // <-- ЗАМЕНА
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Убираем стандартную стрелку, так как у нас есть иконка
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.amber.withOpacity(0.7),
          ),
          // Содержимое - то, что появляется при раскрытии
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Text(
                    l10n.alphaBannerContent, // <-- ЗАМЕНА с новым текстом
                    style: TextStyle(color: Colors.white.withOpacity(0.8), height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: _launchTelegramChannel,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        l10n.alphaBannerFeedback, // <-- ЗАМЕНА
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}