import 'package:flutter/material.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({super.key});

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
        ),
      ),
    );
  }
}
