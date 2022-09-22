import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsButtonExamplePage extends StatelessWidget {
  const AgsButtonExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText('Example AgsButton'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _getSectionWidget(
              title: 'Button Type Primary',
              type: AgsButtonType.primary,
            ),
            _getSectionWidget(
              title: 'Button Type Primary Danger',
              type: AgsButtonType.primaryDanger,
            ),
            _getSectionWidget(
              title: 'Button Type Outline',
              type: AgsButtonType.outline,
            ),
            _getSectionWidget(
              title: 'Button Type Outline Custom Color',
              type: AgsButtonType.outline,
              color: AgsColor.greenWhatsapp,
            ),
            _getSectionWidget(
              title: 'Button Type Rounded',
              type: AgsButtonType.roundedButton,
            ),
            _getSectionWidget(
              title: 'Button Type Rounded Custom Color',
              type: AgsButtonType.roundedButton,
              color: AgsColor.black,
            ),
            _getSectionWidget(
              title: 'Button Type Text',
              type: AgsButtonType.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSectionWidget({
    required String title,
    required AgsButtonType type,
    Color? color,
  }) {
    return Column(
      children: [
        AgsButton(
          title: title,
          type: type,
          color: color,
          onTap: () {},
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 1,
          color: AgsColor.grey20,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
