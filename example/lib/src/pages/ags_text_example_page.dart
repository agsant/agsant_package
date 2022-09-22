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
        child: ListView(
          children: [
            _getSectionWidget(
              title: 'AgsText Type Title',
              type: AgsTextType.title,
            ),
            _getSectionWidget(
              title: 'AgsText Type Title Bold',
              type: AgsTextType.titleBold,
            ),
            _getSectionWidget(
              title: 'AgsText Type Normal',
              type: AgsTextType.normal,
            ),
            _getSectionWidget(
              title: 'AgsText Type Normal Bold',
              type: AgsTextType.normalBold,
            ),
            _getSectionWidget(
              title: 'AgsText Type Caption',
              type: AgsTextType.caption,
            ),
            _getSectionWidget(
              title: 'AgsText Type Caption Bold',
              type: AgsTextType.captionBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSectionWidget({
    required String title,
    required AgsTextType type,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AgsText(
            title,
            type: type,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AgsColor.grey20,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }
}
