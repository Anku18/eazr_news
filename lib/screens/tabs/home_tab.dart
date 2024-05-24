import 'package:carousel_slider/carousel_slider.dart';
import 'package:eazr_news/constants/constants.dart';
import 'package:eazr_news/controllers/bookmark_controller.dart';
import 'package:eazr_news/controllers/top_headline_controller.dart';
import 'package:eazr_news/screens/article_detail_screen.dart';
import 'package:eazr_news/screens/view_all_top_headlines_screen.dart';
import 'package:eazr_news/widgets/category_type_card.dart';
import 'package:eazr_news/widgets/custom_app_bar.dart';
import 'package:eazr_news/widgets/top_headline_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final topHeadlineController = Get.put(TopHeadlineController());
  final bookmarkController = Get.put(BookmarkController());
  int activeIndex = 0;

  @override
  void initState() {
    bookmarkController.getBookmark();
    topHeadlineController.fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'EazrNews').getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Headlines',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewAllTopHeadlinesScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                  ),
                ),
              ],
            ),
            Obx(
              () => CarouselSlider.builder(
                itemCount: topHeadlineController.topHeadlineList.length,
                itemBuilder: (context, index, _) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(
                                article: topHeadlineController.topHeadlineList
                                    .elementAt(index))));
                  },
                  child: TopHeadlineCard(
                    article:
                        topHeadlineController.topHeadlineList.elementAt(index),
                  ),
                ),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4.5,
                    initialPage: activeIndex,
                    onPageChanged: (index, _) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeCenterPage: true),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 5,
                effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 15,
                    activeDotColor: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Categories',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CategoryTypeCard(
                category: categoryList.elementAt(index),
              ),
              itemCount: categoryList.length,
            ),
          ],
        ),
      ),
    );
  }
}
