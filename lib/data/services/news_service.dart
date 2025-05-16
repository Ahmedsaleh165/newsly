import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../../utils/constants.dart';

class NewsService {
  Future<List<Article>> fetchTopHeadlines(
      {String country = 'us', String? category}) async {
    try {
      final response = await http.get(Uri.parse(
          AppConstants.topHeadlines(country: country, category: category)));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] != 'ok') {
          throw Exception('API error: ${json['message']}');
        }
        final articles = (json['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        if (articles.isEmpty) {
          throw Exception(
              'No articles available for the selected country or category');
        }
        return articles;
      } else {
        throw Exception('Failed to load news: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
