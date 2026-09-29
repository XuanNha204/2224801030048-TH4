import 'package:flutter/material.dart';

import '../models/news_category.dart';
import '../services/news_service.dart';
import 'category_news_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.newsService});

  final NewsService newsService;

  IconData _iconFor(String slug) {
    return switch (slug) {
      'thoi-su' => Icons.campaign_outlined,
      'the-gioi' => Icons.public_outlined,
      'kinh-doanh' => Icons.trending_up_rounded,
      'khoa-hoc' => Icons.science_outlined,
      'giai-tri' => Icons.movie_outlined,
      'the-thao' => Icons.sports_soccer_outlined,
      'phap-luat' => Icons.balance_outlined,
      'giao-duc' => Icons.school_outlined,
      'suc-khoe' => Icons.health_and_safety_outlined,
      'doi-song' => Icons.home_outlined,
      'du-lich' => Icons.flight_takeoff_outlined,
      _ => Icons.article_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 700 ? 32.0 : 16.0;
        return GridView.builder(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            16,
            horizontalPadding,
            24,
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisExtent: 124,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: NewsCategories.all.length,
          itemBuilder: (context, index) {
            final category = NewsCategories.all[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => CategoryNewsScreen(
                        category: category,
                        newsService: newsService,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            _iconFor(category.slug),
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              category.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
