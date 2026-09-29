import 'package:flutter/material.dart';

import '../services/news_service.dart';
import '../theme/theme_controller.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'latest_screen.dart';
import 'settings_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final NewsService _newsService = NewsService();
  int _selectedIndex = 0;
  int _homeRefreshToken = 0;
  int _latestRefreshToken = 0;

  static const _titles = <String>[
    'ĐỌC BÁO ONLINE',
    'CHỦ ĐỀ',
    'TIN MỚI NHẤT',
    'CÀI ĐẶT',
  ];

  @override
  void dispose() {
    _newsService.dispose();
    super.dispose();
  }

  void _refreshCurrentPage() {
    setState(() {
      if (_selectedIndex == 0) {
        _homeRefreshToken++;
      } else if (_selectedIndex == 2) {
        _latestRefreshToken++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      HomeScreen(newsService: _newsService, refreshToken: _homeRefreshToken),
      CategoriesScreen(newsService: _newsService),
      LatestScreen(
        newsService: _newsService,
        refreshToken: _latestRefreshToken,
      ),
      SettingsScreen(themeController: widget.themeController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          if (_selectedIndex == 0 || _selectedIndex == 2)
            IconButton(
              onPressed: _refreshCurrentPage,
              tooltip: 'Tải lại',
              icon: const Icon(Icons.refresh_rounded),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _selectedIndex, children: screens),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article_rounded),
            label: 'Tin tổng hợp',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category_rounded),
            label: 'Chủ đề',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up_outlined),
            selectedIcon: Icon(Icons.trending_up_rounded),
            label: 'Tin mới nhất',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
