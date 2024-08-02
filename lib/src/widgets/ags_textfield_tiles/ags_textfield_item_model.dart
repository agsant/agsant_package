class AgsTextFieldItemModel {
  final String text;
  final bool isChecklistType;
  final bool checked;

  AgsTextFieldItemModel({
    required this.text,
    this.checked = false,
    this.isChecklistType = false,
  });

  AgsTextFieldItemModel copyWith({
    String? text,
    bool? checked,
    bool? isChecklistType,
  }) {
    return AgsTextFieldItemModel(
      text: text ?? this.text,
      checked: checked ?? this.checked,
      isChecklistType: isChecklistType ?? this.isChecklistType,
    );
  }
}
