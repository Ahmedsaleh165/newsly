import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../data/models/article.dart';
import '../../data/repositories/news_repository.dart';
import '../widgets/news_card.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppConstants.categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsRepo = Provider.of<NewsRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsly'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppConstants.accentColor,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: AppConstants.categories
              .map((category) => Tab(text: category['name']))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: AppConstants.categories.map((category) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {}); // إعادة تحميل الأخبار
            },
            child: FutureBuilder<List<Article>>(
              future: newsRepo.getTopHeadlines(
                country: 'us',
                category: category['value']?.isEmpty ?? true
                    ? null
                    : category['value'],
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: AppConstants.primaryColor,
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('فشل تحميل الأخبار: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('لا توجد أخبار متاحة حاليًا. جرب لاحقًا.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return NewsCard(article: snapshot.data![index]);
                  },
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
