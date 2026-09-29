class NewsArticle {
  const NewsArticle({
    required this.title,
    required this.link,
    required this.description,
    required this.source,
    this.imageUrl,
    this.publishedAt,
  });

  final String title;
  final String link;
  final String description;
  final String source;
  final String? imageUrl;
  final DateTime? publishedAt;

  String get formattedDate {
    final date = publishedAt;
    if (date == null) return 'Không rõ thời gian';

    final localDate = date.toLocal();
    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');
    return '$hour:$minute · $day/$month/${localDate.year}';
  }
}
