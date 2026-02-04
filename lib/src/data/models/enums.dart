enum LoadingState { idle, loading, success, notFound, error, initial,finished,}
enum SearchMode { all, nearby, city, country, compatible, newUsers, online }
enum PartnerRouletteState { idle, searching, spinning, finished, error, noProfile }
enum FriendshipStatus { friends, requestSent, requestReceived, none }

enum ZodiacFilter {
  all('Все знаки'),
  fire('Огонь (Овен, Лев, Стрелец)'),
  earth('Земля (Телец, Дева, Козерог)'),
  air('Воздух (Близнецы, Весы, Водолей)'),
  water('Вода (Рак, Скорпион, Рыбы)');

  const ZodiacFilter(this.displayName);
  final String displayName;

  // Метод для получения ключей для Firestore
  List<String>? getSignKeys() {
    switch (this) {
      case ZodiacFilter.all:
        return null; // null означает "без фильтра"
      case ZodiacFilter.fire:
        return ['Aries', 'Leo', 'Sagittarius'];
      case ZodiacFilter.earth:
        return ['Taurus', 'Virgo', 'Capricorn'];
      case ZodiacFilter.air:
        return ['Gemini', 'Libra', 'Aquarius'];
      case ZodiacFilter.water:
        return ['Cancer', 'Scorpio', 'Pisces'];
    }
  }
}