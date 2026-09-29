import 'package:flutter/material.dart';

import '../models/news_category.dart';
import '../services/news_service.dart';
import '../widgets/news_list.dart';

class LatestScreen extends StatelessWidget {
  const LatestScreen({
    super.key,
    required this.newsService,
    required this.refreshToken,
  });

  final NewsService newsService;
  final int refreshToken;

  @override
  Widget build(BuildContext context) {
    return NewsList(
      refreshToken: refreshToken,
      loader: () async {
        final articles = await newsService.fetchFeed(NewsCategories.latestFeed);
        return articles.take(10).toList();
      },
    );
  }
}
