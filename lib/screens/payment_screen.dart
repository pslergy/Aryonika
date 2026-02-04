// lib/screens/payment_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:lovequest/l10n/generated/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  const PaymentScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    // Выполняем действие сразу после того, как виджет будет построен
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchUrlAndPop();
    });
  }

  Future<void> _launchUrlAndPop() async {
    final uri = Uri.parse(widget.paymentUrl);

    // Пытаемся открыть URL в внешнем приложении (браузере)
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Если не получилось, показываем ошибку
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть страницу: ${widget.paymentUrl}')),
        );
      }
    }

    // В любом случае, возвращаемся на предыдущий экран
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Пока открывается браузер, показываем индикатор загрузки
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.payment_title),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Открываем страницу оплаты в браузере..."), // TODO: Перевести
          ],
        ),
      ),
    );
  }
}