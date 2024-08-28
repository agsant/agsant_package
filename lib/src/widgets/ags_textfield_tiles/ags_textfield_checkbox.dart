import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_checkbox_controller.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextFieldCheckbox extends StatefulWidget {
  final bool checklistType;
  final List<AgsTextFieldItemModel>? items;
  final EdgeInsetsGeometry? padding;
  final bool requestFocus;

  final void Function(List<AgsTextFieldItemModel>)? onDataUpdated;

  const AgsTextFieldCheckbox({
    super.key,
    required this.checklistType,
    this.requestFocus = true,
    this.onDataUpdated,
    this.padding,
    this.items,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextFieldCheckboxState();
}

class _AgsTextFieldCheckboxState extends State<AgsTextFieldCheckbox> {
  final AgsTextfieldCheckboxController _controller =
      AgsTextfieldCheckboxController();
  bool _requestFocus = true;
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.initialLoad(
      isChecklistType: widget.checklistType,
      paramItems: widget.items,
    );
    _requestFocus = widget.requestFocus;
    _focusedIndex = (widget.items?.length ?? 1) - 1;
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

        return SingleChildScrollView(
          child: Column(
            children: [
              for (int index = 0; index < items.length; index++)
                Padding(
                  padding: widget.padding ??
                      const EdgeInsets.only(bottom: 12.0, left: 10.0),
                  child: AgsTextfieldItem(
                    index: index,
                    key: Key(items[index].key ?? index.toString()),
                    requestFocus: _requestFocus && _focusedIndex == index,
                    param: items[index],
                    isChecklistType: widget.checklistType,
                    showCheckbox: widget.checklistType,
                    onEnter: () {
                      _requestFocus = true;
                      _focusedIndex++;
                      _controller.addItem(index: index);
                    },
                    onChanged: (checked, value) {
                      _requestFocus = true;
                      _controller.updateItem(
                        index: index,
                        value: value,
                        checked: checked,
                      );
                    },
                    onRemove: (i) {
                      _requestFocus = true;
                      if (items.length == 1) {
                        return;
                      }
                      _focusedIndex = i - 1;
                      _controller.remove(i);
                    },
                    onGetFocus: () {
                      _focusedIndex = index;
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
