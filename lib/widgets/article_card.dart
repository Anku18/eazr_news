import 'package:cached_network_image/cached_network_image.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: article.title.toString(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
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
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            article.title ?? '',
            maxLines: 2,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            article.description ?? '',
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
