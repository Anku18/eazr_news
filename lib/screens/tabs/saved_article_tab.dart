import 'package:flutter/material.dart';

class SavedArticleTab extends StatefulWidget {
  const SavedArticleTab({super.key});

  @override
  State<SavedArticleTab> createState() => _SavedArticleTabState();
}

class _SavedArticleTabState extends State<SavedArticleTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Article'),
      ),
    );
  }
}
