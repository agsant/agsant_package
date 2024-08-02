import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_checkbox_controller.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextFieldCheckbox extends StatefulWidget {
  final bool checklistType;

  const AgsTextFieldCheckbox({super.key, required this.checklistType});

  @override
  State<StatefulWidget> createState() => _AgsTextFieldCheckboxState();
}

class _AgsTextFieldCheckboxState extends State<AgsTextFieldCheckbox> {
  final AgsTextfieldCheckboxController _controller =
      AgsTextfieldCheckboxController();

  @override
  void initState() {
    super.initState();
    _controller.initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        List<AgsTextFieldItemModel> items = _controller.items;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AgsTextfieldItem(
              key: Key(index.toString()),
              isChecklistType: widget.checklistType,
              showCheckbox: items[index].isChecklistType,
              onEnter: () {
                _controller.addItem(index: index);
              },
              onChanged: (checked, value) {
                _controller.updateItem(index: index);
              },
            );
          },
        );
      },
    );
  }
}
