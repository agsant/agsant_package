import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String stringFormat({String? format}) {
    String string = format ?? 'dd MMMM yyyy';
    DateFormat dateFormat = DateFormat(string);
    return dateFormat.format(this);
  }
}
