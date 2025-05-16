import 'package:flutter/material.dart';

class AppConstants {
  static const String apiKey = '25d30ab71a43429aaecfb490c1bf989c';
  static const String baseUrl = 'https://newsapi.org/v2';

  // روابط لفئات الأخبار
  static String topHeadlines({String country = 'us', String? category}) {
    String url = '$baseUrl/top-headlines?country=$country';
    if (category != null && category.isNotEmpty) {
      url += '&category=$category';
    }
    url += '&apiKey=$apiKey';
    return url;
  }

  // فئات الأخبار
  static const List<Map<String, String>> categories = [
    {'name': 'All', 'value': ''},
    {'name': 'Business', 'value': 'business'},
    {'name': 'Sports', 'value': 'sports'},
    {'name': 'Technology', 'value': 'technology'},
    {'name': 'Health', 'value': 'health'},
    {'name': 'Science', 'value': 'science'},
    {'name': 'Entertainment', 'value': 'entertainment'},
  ];

  // الألوان
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFFFFCA28);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
}
