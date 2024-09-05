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
  final AgsNotesController _controller = AgsNotesController();

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
                enableInputBorder: true,
                controller: _controller,
                checklistType: false,
                onDataUpdated: (items) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: AgsButton(
                title: 'Checklist',
                onTap: () {
                  _controller.setNotesType?.call(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
