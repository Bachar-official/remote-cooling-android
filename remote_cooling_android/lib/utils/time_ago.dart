class TimeAgo{
  static String timeAgoSinceDate(DateTime date, {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if (difference.inDays > 8) {
      return 'больше недели назад';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 неделю назад' : 'на прошлой неделе';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} дней назад';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 день назад' : 'вчера';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} часов назад';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 час назад' : 'час назад';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} минут назад';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 минуту назад' : 'минуту назад';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} секунд назад';
    } else {
      return 'прямо сейчас';
    }
  }

} 