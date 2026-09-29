import 'package:flutter/material.dart';

import '../models/news_category.dart';
import '../services/news_service.dart';
import '../widgets/news_list.dart';

class CategoryNewsScreen extends StatefulWidget {
  const CategoryNewsScreen({
    super.key,
    required this.category,
    required this.newsService,
  });

  final NewsCategory category;
  final NewsService newsService;

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  int _refreshToken = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name.toUpperCase()),
        actions: [
          IconButton(
            onPressed: () => setState(() => _refreshToken++),
            tooltip: 'Tải lại',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: NewsList(
          refreshToken: _refreshToken,
          loader: () => widget.newsService.fetchFeed(widget.category.feedUrl),
        ),
      ),
    );
  }
}
