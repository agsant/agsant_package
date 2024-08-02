import 'dart:collection';

import 'package:agsant_package/src/widgets/ags_textfield_tiles/ags_textfield_item_model.dart';
import 'package:flutter/material.dart';

class AgsTextfieldCheckboxController extends ChangeNotifier {
  final List<AgsTextFieldItemModel> _items = [];

  UnmodifiableListView<AgsTextFieldItemModel> get items =>
      UnmodifiableListView(_items);

  void initialLoad() {
    _items.add(AgsTextFieldItemModel(text: ''));
  }

  void addItem({
    required int index,
  }) {
    AgsTextFieldItemModel newItem = AgsTextFieldItemModel(text: '');
    _items.insert(index + 1, newItem);
    notifyListeners();
  }

  void updateItem({required int index, String? value, bool? checked}) {
    AgsTextFieldItemModel item = _items[index];

    _items[index] = item.copyWith(
      text: value,
      checked: checked,
    );
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
