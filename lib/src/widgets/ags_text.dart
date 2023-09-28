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

  late TextStyle _baseTextStyle;

  AgsText(
    this.text, {
    Key? key,
    this.type = AgsTextType.normal,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.underLine = false,
    this.textStyle,
  }) : super(key: key) {
    _baseTextStyle = getTextStyleBaseOnType(type, color, underLine);
    TextStyle? customStyle = textStyle;
    if (customStyle != null) {
      _baseTextStyle = _baseTextStyle.merge(customStyle);
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
