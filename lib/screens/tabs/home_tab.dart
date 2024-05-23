import 'package:carousel_slider/carousel_slider.dart';
import 'package:eazr_news/constants/constants.dart';
import 'package:eazr_news/widgets/category_type_card.dart';
import 'package:eazr_news/widgets/top_headline_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int activeIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Eazr',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
              TextSpan(
                text: 'News',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Image.asset(
        //       'assets/images/search_icon.png',
        //       color: Colors.black,
        //       width: 22,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.bookmark_outline,
        //       size: 26,
        //     ),
        //   ),
        // ],
      ),
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
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, _) => const TopHeadlineCard(),
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 4.5,
                  initialPage: 1,
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
                mainAxisSpacing: 10.0,
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
