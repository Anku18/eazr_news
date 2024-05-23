import 'package:eazr_news/controllers/top_headline_controller.dart';
import 'package:eazr_news/screens/article_detail_screen.dart';
import 'package:eazr_news/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllTopHeadlinesScreen extends StatefulWidget {
  const ViewAllTopHeadlinesScreen({
    super.key,
  });

  @override
  _ViewAllTopHeadlinesScreenState createState() =>
      _ViewAllTopHeadlinesScreenState();
}

class _ViewAllTopHeadlinesScreenState extends State<ViewAllTopHeadlinesScreen> {
  final TopHeadlineController topHeadlineController =
      Get.put(TopHeadlineController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    topHeadlineController.fetchTopHeadlines();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !topHeadlineController.hasReachedMax.value &&
        !topHeadlineController.isFetchingMore.value) {
      topHeadlineController.fetchTopHeadlines();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    Get.delete<TopHeadlineController>();
    super.dispose();
  }

  Future<void> _refreshNews() async {
    await topHeadlineController.fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Headlines',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (topHeadlineController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (topHeadlineController.viewAllTopHeadlines.isEmpty) {
          return const Center(child: Text('No news available'));
        } else {
          return RefreshIndicator(
            onRefresh: _refreshNews,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              controller: _scrollController,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: topHeadlineController.hasReachedMax.value
                  ? topHeadlineController.viewAllTopHeadlines.length
                  : topHeadlineController.viewAllTopHeadlines.length + 1,
              itemBuilder: (context, index) {
                if (index >= topHeadlineController.viewAllTopHeadlines.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final article =
                    topHeadlineController.viewAllTopHeadlines[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            article: article,
                          ),
                        ),
                      );
                    },
                    child: ArticleCard(
                      article: article,
                    ));
              },
            ),
          );
        }
      }),
    );
  }
}
