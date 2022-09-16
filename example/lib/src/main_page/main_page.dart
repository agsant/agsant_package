import 'package:agsant_package/agsant_package.dart';
import 'package:example/src/pages/ags_text_example_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText(
          'Example Page',
          type: AgsTextType.titleBold,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _getItem(
            context: context,
            title: 'Ags Text',
            targetWidget: const AgsTextExamplePage(),
          )
        ],
      ),
    );
  }

  Widget _getItem({
    required BuildContext context,
    required String title,
    required Widget targetWidget,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => targetWidget,
        ),
      ),
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 8,
          ),
          child: AgsText(
            title,
            type: AgsTextType.title,
          ),
        ),
      ),
    );
  }
}
