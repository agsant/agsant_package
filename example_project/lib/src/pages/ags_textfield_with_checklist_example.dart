import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsTextfieldWithChecklistExample extends StatefulWidget {
  const AgsTextfieldWithChecklistExample({super.key});

  @override
  State<StatefulWidget> createState() =>
      _AgsTextfieldWithChecklistExampleState();
}

class _AgsTextfieldWithChecklistExampleState
    extends State<AgsTextfieldWithChecklistExample> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText('Example TextField with Checklist'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: AgsTextFieldCheckbox(
                checklistType: true,
                onDataUpdated: (items) {
                  print('=== data updated ===');
                  for (AgsTextFieldItemModel item in items) {
                    print(
                        '${item.text} : ${item.checked} : ${item.isChecklistType}');
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: AgsButton(
                title: 'Checklist',
                onTap: () {
                  setState(() {
                    checked = !checked;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
