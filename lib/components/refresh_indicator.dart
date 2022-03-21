// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CommonRefreshIndicator extends StatelessWidget {
  const CommonRefreshIndicator({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: _refreshFurniture,
      color: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  Future<void> _refreshFurniture() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
