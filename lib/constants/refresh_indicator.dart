import 'package:flutter/material.dart';

class CommonRefreshIndicator extends StatelessWidget {
  CommonRefreshIndicator({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: _refreshFurniture,
      color: Colors.black,
    );
  }

  Future<void> _refreshFurniture() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
