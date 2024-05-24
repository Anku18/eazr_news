import 'package:cached_network_image/cached_network_image.dart';
import 'package:eazr_news/controllers/bookmark_controller.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;
  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  String? formattedDate;

  final bookmarkController = Get.find<BookmarkController>();
  @override
  void initState() {
    DateTime originalDate =
        DateTime.parse(widget.article.publishedAt.toString());
    formattedDate = DateFormat('d MMMM y', 'en_US').format(originalDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() => InkWell(
            onTap: () {
              if (bookmarkController.isBookmarked(widget.article)) {
                bookmarkController.removeBookmark(widget.article);
              } else {
                bookmarkController.addBookmark(widget.article);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 1.5),
                    ),
                  ]),
              child: bookmarkController.isBookmarked(widget.article)
                  ? Icon(
                      Icons.bookmark,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(
                      Icons.bookmark_border_outlined,
                      size: 30,
                    ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.article.source?.name.toString().capitalizeFirst ??
                      'Unknown',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 2,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  formattedDate ?? '',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.article.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            Hero(
              tag: widget.article.title.toString(),
              child: Container(
                height: MediaQuery.of(context).size.height / 3.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.article.urlToImage.toString(),
                    height: MediaQuery.of(context).size.height / 4.5,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Image.asset(
                        'assets/images/error_image.webp',
                        height: MediaQuery.of(context).size.height / 4.5,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.article.description ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.article.content ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
