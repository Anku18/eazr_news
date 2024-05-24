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
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 1.5),
              ),
            ]),
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
              CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Center(
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
