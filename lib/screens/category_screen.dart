import 'package:eazr_news/controllers/category_controller.dart';
import 'package:eazr_news/screens/article_detail_screen.dart';
import 'package:eazr_news/widgets/article_card.dart';
import 'package:eazr_news/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    categoryController.fetchNewsByCategory(category: widget.category);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !categoryController.hasReachedMax.value &&
        !categoryController.isFetchingMore.value) {
      categoryController.fetchNewsByCategory(
          isLoadMore: true, category: widget.category);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    Get.delete<CategoryController>();
    super.dispose();
  }

  Future<void> _refreshNews() async {
    await categoryController.fetchNewsByCategory(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.category.capitalizeFirst.toString(),
      ).getAppBar(),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryController.articles.isEmpty) {
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
              itemCount: categoryController.hasReachedMax.value
                  ? categoryController.articles.length
                  : categoryController.articles.length + 1,
              itemBuilder: (context, index) {
                if (index >= categoryController.articles.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final article = categoryController.articles[index];
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
