class Article {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'بدون عنوان',
      description: json['description'] ?? 'بدون وصف',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
