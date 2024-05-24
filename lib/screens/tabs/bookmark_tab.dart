import 'package:eazr_news/controllers/bookmark_controller.dart';
import 'package:eazr_news/screens/article_detail_screen.dart';
import 'package:eazr_news/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/article_card.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({super.key});

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> {
  final bookmarkController = Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bookmarks').getAppBar(),
      body: Obx(
        () => bookmarkController.bookmarkList.isEmpty
            ? const Center(
                child: Text('No bookmarks available'),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: bookmarkController.bookmarkList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(
                              article: bookmarkController.bookmarkList
                                  .elementAt(index),
                            ),
                          ),
                        );
                      },
                      child: ArticleCard(
                        article:
                            bookmarkController.bookmarkList.elementAt(index),
                      ));
                },
              ),
      ),
    );
  }
}
