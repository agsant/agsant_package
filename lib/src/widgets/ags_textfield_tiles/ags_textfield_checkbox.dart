import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_notes_controller.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_checkbox_controller.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item.dart';
import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextFieldCheckbox extends StatefulWidget {
  final bool checklistType;
  final List<AgsTextFieldItemModel>? items;
  final EdgeInsetsGeometry? padding;
  final bool requestFocus;
  final AgsNotesController? controller;
  final bool? enableInputBorder;
  final void Function({required int index, required bool checked})?
      onFocusGained;
  final void Function({required int index, required bool checked})? onFocusLost;

  final void Function(List<AgsTextFieldItemModel>)? onDataUpdated;

  const AgsTextFieldCheckbox({
    super.key,
    required this.checklistType,
    this.requestFocus = true,
    this.onDataUpdated,
    this.padding,
    this.items,
    this.controller,
    this.enableInputBorder,
    this.onFocusGained,
    this.onFocusLost,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextFieldCheckboxState();
}

class _AgsTextFieldCheckboxState extends State<AgsTextFieldCheckbox> {
  final AgsTextfieldCheckboxController _controller =
      AgsTextfieldCheckboxController();
  AgsNotesController? _externalController;
  bool _requestFocus = true;
  int _focusedIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _externalController = widget.controller;
      _externalController?.setNotesType = _setNotesType;
    }

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

  void _setNotesType(bool value) {
    _controller.updateItem(
      index: _focusedIndex,
      checked: !value ? null : false,
      isChecklistType: value,
    );
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
                    enableInputBorder: widget.enableInputBorder ?? false,
                    key: Key(items[index].key ?? index.toString()),
                    requestFocus: _requestFocus && _focusedIndex == index,
                    param: items[index],
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
                      if (items[index].isChecklistType) {
                        _controller.updateItem(
                          index: index,
                          value: '',
                          checked: false,
                          isChecklistType: false,
                        );
                        return;
                      }

                      if (items.length == 1) {
                        return;
                      }
                      _focusedIndex = i - 1;
                      _controller.remove(i);
                    },
                    onFocusGained: () {
                      _focusedIndex = index;
                      widget.onFocusGained?.call(
                        index: index,
                        checked: items[index].isChecklistType,
                      );
                    },
                    onFocusLost: () {
                      _focusedIndex = -1;
                      widget.onFocusLost?.call(
                        index: index,
                        checked: items[index].isChecklistType,
                      );
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
