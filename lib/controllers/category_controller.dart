import 'package:dio/dio.dart';
import 'package:eazr_news/constants/constants.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = true.obs;
  var isFetchingMore = false.obs;
  var currentPage = 1;
  var hasReachedMax = false.obs;
  var dio = Dio();

  Future<void> fetchNewsByCategory(
      {bool isLoadMore = false, required String category}) async {
    // if (isFetchingMore.value || (isLoading.value && !isLoadMore)) return;
    try {
      if (isLoadMore) {
        currentPage++;
        isFetchingMore(true);
      } else {
        currentPage = 1;
        isLoading(true);
      }

      final response = await dio.get(baseUrl,
          options: Options(headers: {
            "X-Api-Key": newsApiKey,
          }),
          queryParameters: {
            "country": 'in',
            "category": category,
            "page": currentPage,
            "pageSize": 10,
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
        Get.snackbar('Error', 'Failed to load news',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      isFetchingMore(false);
    }
  }
}
