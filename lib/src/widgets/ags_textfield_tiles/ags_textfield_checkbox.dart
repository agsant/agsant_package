import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_checkbox_controller.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextFieldCheckbox extends StatefulWidget {
  final bool checklistType;
  final List<AgsTextFieldItemModel>? items;

  final void Function(List<AgsTextFieldItemModel>)? onDataUpdated;

  const AgsTextFieldCheckbox({
    super.key,
    required this.checklistType,
    this.onDataUpdated,
    this.items,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextFieldCheckboxState();
}

class _AgsTextFieldCheckboxState extends State<AgsTextFieldCheckbox> {
  final AgsTextfieldCheckboxController _controller =
      AgsTextfieldCheckboxController();

  @override
  void initState() {
    super.initState();
    _controller.initialLoad(isChecklistType: widget.checklistType);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        List<AgsTextFieldItemModel> items = _controller.items;
        widget.onDataUpdated?.call(items);

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AgsTextfieldItem(
              key: Key(index.toString()),
              isChecklistType: widget.checklistType,
              showCheckbox: widget.checklistType,
              onEnter: () {
                _controller.addItem(index: index);
              },
              onChanged: (checked, value) {
                _controller.updateItem(
                  index: index,
                  value: value,
                  checked: checked,
                );
              },
              onRemove: () {
                if (items.length == 1) {
                  return;
                }
                _controller.remove(index);
              },
            );
          },
        );
      },
    );
  }
}
