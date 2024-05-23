import 'package:cached_network_image/cached_network_image.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_border,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('BBC News'),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('11 MAY 2024')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Title'),
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
            const Text('Desc'),
            const SizedBox(
              height: 10,
            ),
            const Text('Content'),
          ],
        ),
      ),
    );
  }
}
