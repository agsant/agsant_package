import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  @Deprecated('Use format(...) instead, to support locale')
  String stringFormat({String? format}) {
    String string = format ?? 'dd MMMM yyyy';
    DateFormat dateFormat = DateFormat(string);
    return dateFormat.format(this);
  }

  String format({String? format, String? locale}) {
    String string = format ?? 'dd MMMM yyyy';
    DateFormat dateFormat = DateFormat(string, locale);
    return dateFormat.format(this);
  }
}
