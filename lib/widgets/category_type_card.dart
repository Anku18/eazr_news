import 'package:eazr_news/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryTypeCard extends StatelessWidget {
  final String category;
  const CategoryTypeCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              category: category,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const CircleAvatar(
                radius: 12,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
