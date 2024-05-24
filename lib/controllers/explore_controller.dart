import 'package:dio/dio.dart';
import 'package:eazr_news/constants/constants.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = false.obs;
  var isFetchingMore = false.obs;
  var currentPage = 1;
  var hasReachedMax = false.obs;
  var dio = Dio();

  Future<void> searchArticle(
      {bool isLoadMore = false, required String keyword}) async {
    // if (isFetchingMore.value || (isLoading.value && !isLoadMore)) return;
    try {
      if (isLoadMore) {
        currentPage++;
        isFetchingMore(true);
      } else {
        currentPage = 1;
        isLoading(true);
      }

      var response = await dio.get(baseUrlForSearch,
          options: Options(headers: {
            "X-Api-Key": newsApiKey,
          }),
          queryParameters: {
            "q": keyword,
            "pageSize": 50,
          });

      if (response.statusCode == 200) {
        final List<dynamic> fetchedArticlesJson = response.data['articles'];
        final List<ArticleModel> fetchedArticles = fetchedArticlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        if (isLoadMore) {
          articles.addAll(fetchedArticles);
          if (fetchedArticles.length < 10) {
            hasReachedMax(true);
          }
        } else {
          articles.value = fetchedArticles;
          hasReachedMax(fetchedArticles.length < 10);
        }
      } else {
        // Get.snackbar('Error', 'Failed to load news');
      }
    } catch (e) {
      // Get.snackbar('Error', 'Failed to load news: $e');
    } finally {
      isLoading(false);
      isFetchingMore(false);
    }
  }
}
