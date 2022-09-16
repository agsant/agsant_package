import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsTextExamplePage extends StatelessWidget {
  const AgsTextExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText('Example Ags Text'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: AgsText(
            'Lorem Ipsum Lorem Ipsum',
            type: AgsTextType.titleBold,
          ),
        ),
      ),
    );
  }
}
