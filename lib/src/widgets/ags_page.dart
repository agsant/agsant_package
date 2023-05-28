import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsPage extends StatelessWidget {
  final Widget child;
  final String title;
  final Color titleColor;

  const AgsPage({
    super.key,
    required this.title,
    required this.child,
    this.titleColor = AgsColor.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: titleColor,
          size: 24,
        ),
      ),
      body: child,
    );
  }
}
