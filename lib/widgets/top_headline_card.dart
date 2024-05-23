import 'package:cached_network_image/cached_network_image.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:flutter/material.dart';

class TopHeadlineCard extends StatelessWidget {
  final ArticleModel article;
  const TopHeadlineCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Hero(
            tag: article.title.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage.toString(),
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
          Container(
            margin: const EdgeInsets.only(top: 120),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            padding: const EdgeInsets.all(6),
            child: Text(
              article.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
