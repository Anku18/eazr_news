import 'package:eazr_news/config/theme_data.dart';
import 'package:eazr_news/controllers/theme_controller.dart';
import 'package:eazr_news/main.dart';
import 'package:eazr_news/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final List<String> name = [
    "Sports Blue",
    "Radial Red",
    "Kingfisher Daisy",
    "Pantone",
  ];
  final List<Color> color = [
    const Color(0xFF1E38FC),
    const Color(0xFFFF385C),
    const Color(0xFF604A7B),
    const Color(0xFFFFA500)
  ];
  final List<Color> bgColor = [
    const Color(0xFFEFF1FF),
    const Color(0xFFFFE5EA),
    const Color(0xFFF4EBFF),
    const Color(0xFFFFF5E3),
  ];
  int index = 0;
  ThemeController controller = Get.find<ThemeController>();

  @override
  void initState() {
    if (themeBox!.get("colorTheme") != null) {
      index = themeBox!.get("colorTheme");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Theme Color").getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Theme Color",
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              "Select the color palatte according to your choice.",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    this.index = index;
                    setState(() {});
                  },
                  child: ColorThemeItem(
                    color: color.elementAt(index),
                    title: name.elementAt(index),
                    bgColor: bgColor.elementAt(index),
                    isSelected: this.index == index,
                  ),
                );
              },
              itemCount: color.length,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width * 0.5, 50),
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  controller.theme.value = index;
                  if (themeBox != null) {
                    themeBox!.put("colorTheme", index);
                  }
                  CustomThemeData.changeStatusBarColor(context);
                },
                child: Text(
                  "Set Color Theme",
                  style: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorThemeItem extends StatelessWidget {
  final String title;
  final Color color;
  final Color bgColor;
  final bool isSelected;
  const ColorThemeItem({
    super.key,
    required this.title,
    required this.color,
    required this.bgColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: color,
                      width: 2.0,
                    )
                  : null,
              borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.only(top: 12.0, bottom: 12, left: 36.0),
          child: Container(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Color Name "),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium!.merge(
                          TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            color: color,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: CircleAvatar(
            minRadius: 45.0,
            backgroundColor: color,
          ),
        ),
      ],
    );
  }
}
