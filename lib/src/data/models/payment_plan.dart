// lib/src/data/models/payment_plan.dart

enum PriceTier { monthly }

class PaymentPlan {
  final PriceTier tier;
  final String price;
  final String currencySymbol;
  final String description;

  const PaymentPlan({
    required this.tier,
    required this.price,
    required this.currencySymbol,
    required this.description,
  });

  // Фабрика для получения нужного плана в зависимости от локали
  factory PaymentPlan.forLocale(String languageCode) {
    if (languageCode == 'ru') {
      return const PaymentPlan(
        tier: PriceTier.monthly,
        price: '399',
        currencySymbol: '₽',
        description: 'в месяц',
      );
    } else {
      return const PaymentPlan(
        tier: PriceTier.monthly,
        price: '6.99',
        currencySymbol: '\$',
        description: 'per month',
      );
    }
  }
}