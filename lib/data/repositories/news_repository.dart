import '../services/news_service.dart';
import '../models/article.dart';

class NewsRepository {
  final NewsService _newsService = NewsService();

  Future<List<Article>> getTopHeadlines(
      {String country = 'us', String? category}) async {
    return await _newsService.fetchTopHeadlines(
        country: country, category: category);
  }
}
