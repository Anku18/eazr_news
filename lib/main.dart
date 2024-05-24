import 'package:eazr_news/config/theme_data.dart';
import 'package:eazr_news/controllers/theme_controller.dart';
import 'package:eazr_news/models/article_model.dart';
import 'package:eazr_news/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box? bookmarkArticleBox;
Box? themeBox;
ThemeController themeData = Get.put(ThemeController());
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(SourceAdapter());
  themeBox = await Hive.openBox("themeData");
  if (themeBox!.get("isLightMode") != null) {
    themeData.isLightMode.value = themeBox!.get("isLightMode");
  } else {
    await themeBox!.put(
      "isLightMode",
      themeData.isLightMode.value,
    );
  }
  bookmarkArticleBox = await Hive.openBox<ArticleModel>('bookmarkArticle');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Eazr News',
        debugShowCheckedModeBanner: false,
        darkTheme: CustomThemeData()
            .getThemeData(themeData.isLightMode.value, themeData.theme.value),
        theme: CustomThemeData()
            .getThemeData(themeData.isLightMode.value, themeData.theme.value),
        home: const HomeScreen(),
      ),
    );
  }
}
