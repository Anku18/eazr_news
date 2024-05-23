import 'package:eazr_news/controllers/explore_controller.dart';
import 'package:eazr_news/screens/article_detail_screen.dart';
import 'package:eazr_news/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final exploreController = Get.put(ExploreController());
  final search = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !exploreController.hasReachedMax.value &&
        !exploreController.isFetchingMore.value) {
      exploreController.searchArticle(keyword: search.text);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    Get.delete<ExploreController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
              height: 50,
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 6,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Center(
                child: TextField(
                  controller: search,
                  onChanged: (value) {
                    exploreController.articles.clear();
                    exploreController.searchArticle(keyword: value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search news here.....',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Image.asset(
                        'assets/images/search_icon.png',
                        color: Colors.black,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
      body: Obx(() {
        if (exploreController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (exploreController.articles.isEmpty) {
          return const SizedBox();
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            controller: _scrollController,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: exploreController.hasReachedMax.value
                ? exploreController.articles.length
                : exploreController.articles.length + 1,
            itemBuilder: (context, index) {
              if (index >= exploreController.articles.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final article = exploreController.articles[index];
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
          );
        }
      }),
    );
  }
}
