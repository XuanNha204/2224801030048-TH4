import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../models/news_article.dart';
import '../utils/html_text.dart';

class NewsService {
  NewsService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<NewsArticle>> fetchFeed(String feedUrl) async {
    final response = await _client
        .get(
          Uri.parse(feedUrl),
          headers: const {
            'Accept': 'application/rss+xml, application/xml, text/xml',
            'User-Agent': 'DocBaoOnline/1.0',
          },
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw NewsException('Không thể tải tin (mã ${response.statusCode}).');
    }

    try {
      final xmlString = utf8.decode(response.bodyBytes);
      final document = XmlDocument.parse(xmlString);
      return document.findAllElements('item').map(_parseItem).toList();
    } on XmlParserException {
      throw const NewsException('Dữ liệu RSS không đúng định dạng.');
    } on FormatException {
      throw const NewsException('Không thể đọc dữ liệu RSS.');
    }
  }

  NewsArticle _parseItem(XmlElement item) {
    final title = _textOf(item, 'title');
    final rawDescription = _textOf(item, 'description');
    var description = plainTextFromHtml(rawDescription);

    if (description.startsWith(title)) {
      description = description.substring(title.length).trim();
    }

    final imageUrl = extractFirstImageUrl(rawDescription);
    return NewsArticle(
      title: title,
      link: _textOf(item, 'link'),
      description: description,
      source: 'VnExpress',
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
      publishedAt: _parseRssDate(_textOf(item, 'pubDate')),
    );
  }

  String _textOf(XmlElement parent, String name) {
    return parent.getElement(name)?.innerText.trim() ?? '';
  }

  DateTime? _parseRssDate(String value) {
    final normalized = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    final match = RegExp(
      r'^(?:\w{3}, )?(\d{1,2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2}) ([+-])(\d{2})(\d{2})$',
    ).firstMatch(normalized);
    if (match == null) return DateTime.tryParse(normalized);

    const months = <String, int>{
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    final month = months[match.group(2)];
    if (month == null) return null;

    final localClock = DateTime.utc(
      int.parse(match.group(3)!),
      month,
      int.parse(match.group(1)!),
      int.parse(match.group(4)!),
      int.parse(match.group(5)!),
      int.parse(match.group(6)!),
    );
    final offset = Duration(
      hours: int.parse(match.group(8)!),
      minutes: int.parse(match.group(9)!),
    );
    return match.group(7) == '+'
        ? localClock.subtract(offset)
        : localClock.add(offset);
  }

  void dispose() => _client.close();
}

class NewsException implements Exception {
  const NewsException(this.message);

  final String message;

  @override
  String toString() => message;
}
