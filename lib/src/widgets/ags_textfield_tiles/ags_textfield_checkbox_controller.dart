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
      _items.add(AgsTextFieldItemModel(text: ''));
    }
    _isChecklistType = isChecklistType;
  }

  void addItem({
    required int index,
  }) {
    AgsTextFieldItemModel newItem = AgsTextFieldItemModel(
      text: '',
      isChecklistType: _isChecklistType,
    );
    _items.insert(index + 1, newItem);
    notifyListeners();
  }

  void updateItem({required int index, String? value, bool? checked}) {
    if (index >= items.length) return;

    AgsTextFieldItemModel item = _items[index];

    _items[index] = item.copyWith(
      text: value,
      checked: checked,
      isChecklistType: _isChecklistType,
    );
    notifyListeners();
  }

  void remove(int index) {
    if (index >= items.length) return;

    _items.removeAt(index);
    notifyListeners();
  }
}
