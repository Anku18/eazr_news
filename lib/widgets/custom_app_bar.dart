import 'package:flutter/material.dart';

class CustomAppBar {
  final String title;
  final List<Widget>? action;
  final PreferredSize? bottom;

  const CustomAppBar({
    required this.title,
    this.action,
    this.bottom,
  });

  PreferredSizeWidget getAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
      ),
      centerTitle: true,
      leadingWidth: 30.0,
      actions: action,
      bottom: bottom,
    );
  }
}
