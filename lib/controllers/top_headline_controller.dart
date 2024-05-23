import 'package:dio/dio.dart';
import 'package:eazr_news/constants/constants.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:get/get.dart';

class TopHeadlineController extends GetxController {
  var isLoading = true.obs;
  var topHeadlineList = <ArticleModel>[].obs;
  var dio = Dio();

 
  void fetchNews() async {
    try {
      var response = await dio.get(baseUrl, queryParameters: {
        "apiKey": newsApiKey,
        "sources": 'abc-news',
        "page": 0,
        "pageSize": 5,
      });
      if (response.statusCode == 200) {
        final List<dynamic> fetchedArticlesJson = response.data['articles'];
        final List<ArticleModel> fetchedArticles = fetchedArticlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        topHeadlineList.value = fetchedArticles;
      }
    } finally {
      isLoading.value = false;
    }
  }

  var viewAllTopHeadlines = <ArticleModel>[].obs;
  var isViewAllLoading = true.obs;
  var isFetchingMore = false.obs;
  var currentPage = 1;
  var hasReachedMax = false.obs;

  Future<void> fetchTopHeadlines({bool isLoadMore = false}) async {
    // if (isFetchingMore.value || (isLoading.value && !isLoadMore)) return;
    try {
      if (isLoadMore) {
        currentPage++;
        isFetchingMore(true);
      } else {
        currentPage = 1;
        isLoading(true);
      }

      final response = await dio.get(baseUrl, queryParameters: {
        "apiKey": newsApiKey,
        "sources": 'abc-news',
        "page": currentPage,
        "pageSize": 10
      });
      print(response.data);
      if (response.statusCode == 200) {
        final List<dynamic> fetchedArticlesJson = response.data['articles'];
        final List<ArticleModel> fetchedArticles = fetchedArticlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        if (isLoadMore) {
          viewAllTopHeadlines.addAll(fetchedArticles);
          if (fetchedArticles.length < 10) {
            hasReachedMax(true);
          }
        } else {
          viewAllTopHeadlines.value = fetchedArticles;
          hasReachedMax(fetchedArticles.length < 10);
        }
      } else {
        Get.snackbar('Error', 'Failed to load news');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news: $e');
    } finally {
      isLoading(false);
      isFetchingMore(false);
    }
  }
}
