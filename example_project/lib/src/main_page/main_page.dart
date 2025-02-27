import 'package:agsant_package/agsant_package.dart';
import 'package:example_project/src/pages/ags_button_example_page.dart';
import 'package:example_project/src/pages/ags_camera_example_page.dart';
import 'package:example_project/src/pages/ags_checkbox_page.dart';
import 'package:example_project/src/pages/ags_date_picker_example_page.dart';
import 'package:example_project/src/pages/ags_image_example_page.dart';
import 'package:example_project/src/pages/ags_text_area_page.dart';
import 'package:example_project/src/pages/ags_text_example_page.dart';
import 'package:example_project/src/pages/ags_textfield_with_checklist_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
          ),
          _getItem(
            context: context,
            title: 'Ags Button',
            targetWidget: const AgsButtonExamplePage(),
          ),
          _getItem(
            context: context,
            title: 'Ags Image',
            targetWidget: const AgsImageExamplePage(),
          ),
          _getItem(
            context: context,
            title: 'Ags Date Picker',
            targetWidget: const AgsDatePickerExamplePage(),
          ),
          _getItem(
            context: context,
            title: 'Text Area',
            targetWidget: const AgsTextAreaPage(),
          ),
          _getItem(
            context: context,
            title: 'Checkbox',
            targetWidget: const AgsCheckboxPage(),
          ),
          _getItem(
            context: context,
            title: 'TextField Checkbox',
            targetWidget: const AgsTextfieldWithChecklistExample(),
          ),
          _getItem(
            context: context,
            title: 'Camera',
            targetWidget: const AgsCameraExamplePage(),
          ),
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
