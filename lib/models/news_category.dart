class NewsCategory {
  const NewsCategory({
    required this.name,
    required this.feedUrl,
    required this.slug,
  });

  final String name;
  final String feedUrl;
  final String slug;
}

abstract final class NewsCategories {
  static const latestFeed = 'https://vnexpress.net/rss/tin-moi-nhat.rss';

  static const all = <NewsCategory>[
    NewsCategory(
      name: 'Thời sự',
      slug: 'thoi-su',
      feedUrl: 'https://vnexpress.net/rss/thoi-su.rss',
    ),
    NewsCategory(
      name: 'Thế giới',
      slug: 'the-gioi',
      feedUrl: 'https://vnexpress.net/rss/the-gioi.rss',
    ),
    NewsCategory(
      name: 'Kinh doanh',
      slug: 'kinh-doanh',
      feedUrl: 'https://vnexpress.net/rss/kinh-doanh.rss',
    ),
    NewsCategory(
      name: 'Khoa học',
      slug: 'khoa-hoc',
      feedUrl: 'https://vnexpress.net/rss/khoa-hoc.rss',
    ),
    NewsCategory(
      name: 'Giải trí',
      slug: 'giai-tri',
      feedUrl: 'https://vnexpress.net/rss/giai-tri.rss',
    ),
    NewsCategory(
      name: 'Thể thao',
      slug: 'the-thao',
      feedUrl: 'https://vnexpress.net/rss/the-thao.rss',
    ),
    NewsCategory(
      name: 'Pháp luật',
      slug: 'phap-luat',
      feedUrl: 'https://vnexpress.net/rss/phap-luat.rss',
    ),
    NewsCategory(
      name: 'Giáo dục',
      slug: 'giao-duc',
      feedUrl: 'https://vnexpress.net/rss/giao-duc.rss',
    ),
    NewsCategory(
      name: 'Sức khỏe',
      slug: 'suc-khoe',
      feedUrl: 'https://vnexpress.net/rss/suc-khoe.rss',
    ),
    NewsCategory(
      name: 'Đời sống',
      slug: 'doi-song',
      feedUrl: 'https://vnexpress.net/rss/doi-song.rss',
    ),
    NewsCategory(
      name: 'Du lịch',
      slug: 'du-lich',
      feedUrl: 'https://vnexpress.net/rss/du-lich.rss',
    ),
  ];
}
