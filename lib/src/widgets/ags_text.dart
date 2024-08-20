import 'package:agsant_package/src/config/ags_text_styles.dart';
import 'package:agsant_package/src/enums/ags_text_type.dart';
import 'package:flutter/cupertino.dart';

class AgsText extends StatelessWidget {
  final String text;
  final AgsTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool underLine;
  final TextStyle? textStyle;

  late final TextStyle _baseTextStyle;

  AgsText(
    this.text, {
    super.key,
    this.type = AgsTextType.normal,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.underLine = false,
    this.textStyle,
  }) {
    TextStyle style = getTextStyleBaseOnType(type, color, underLine);
    TextStyle? customStyle = textStyle;
    if (customStyle != null) {
      _baseTextStyle = style.merge(customStyle);
    } else {
      _baseTextStyle = style;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _baseTextStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
