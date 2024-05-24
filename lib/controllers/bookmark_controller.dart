import 'package:eazr_news/main.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  RxList<ArticleModel> bookmarkList = RxList();

  void addBookmark(ArticleModel article) {
    bookmarkList.add(article);
    bookmarkArticleBox?.put(article.title, article);
  }

  void removeBookmark(ArticleModel article) {
    bookmarkList.remove(article);
    bookmarkArticleBox?.delete(article.title);
  }

  bool isBookmarked(ArticleModel article) {
    return bookmarkList.contains(article);
  }

  void getBookmark() {
    bookmarkList.value =
        bookmarkArticleBox!.values.toList() as List<ArticleModel>;
  }
}
