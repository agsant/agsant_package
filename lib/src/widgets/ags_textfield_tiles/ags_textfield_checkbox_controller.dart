import 'dart:collection';

import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextfieldCheckboxController extends ChangeNotifier {
  final List<AgsTextFieldItemModel> _items = [];
  bool _isChecklistType = false;

  UnmodifiableListView<AgsTextFieldItemModel> get items =>
      UnmodifiableListView(_items);

  void initialLoad({
    required bool isChecklistType,
    List<AgsTextFieldItemModel>? paramItems,
  }) {
    if (paramItems != null) {
      _items.addAll(paramItems);
      notifyListeners();
    } else {
      _items.add(AgsTextFieldItemModel(
        text: '',
        key: DateTime.timestamp().toString(),
        isChecklistType: isChecklistType,
      ));
    }
    _isChecklistType = isChecklistType;
  }

  void addItem({
    required int index,
  }) {
    if (_items.length > index) {
      _isChecklistType = _items[index].isChecklistType;
    }
    AgsTextFieldItemModel newItem = AgsTextFieldItemModel(
      text: '',
      isChecklistType: _isChecklistType,
      key: DateTime.timestamp().toString(),
    );
    _items.insert(index + 1, newItem);
    notifyListeners();
  }

  void updateItem({
    required int index,
    String? value,
    bool? checked,
    bool? isChecklistType,
  }) {
    if (index >= items.length) return;

    AgsTextFieldItemModel item = _items[index];

    if (_items.length == 1) {
      _isChecklistType = _items.first.isChecklistType;
    }

    _items[index] = item.copyWith(
      text: value,
      checked: checked,
      isChecklistType: isChecklistType,
    );

    notifyListeners();
  }

  void remove(int index) {
    if (index >= items.length) return;

    _items.removeAt(index);
    notifyListeners();
  }
}
