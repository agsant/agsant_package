import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsTextAreaPage extends StatelessWidget {
  const AgsTextAreaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AgsPage(
      title: 'Text Area',
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: AgsTextArea(
          maxLength: 156,
        ),
      ),
    );
  }
}
