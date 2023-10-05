import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

extension TimeExtension on TimeOfDay {
  String getStringTime({TimeType type = TimeType.type12}) {
    DayPeriod period = this.period;
    String minute = _getStringFormat(this.minute);

    switch (type) {
      case TimeType.type12:
        String hour = _getStringFormat(hourOfPeriod);
        return '$hour:$minute ${period.name}';
      case TimeType.type24:
        String hour = _getStringFormat(this.hour);
        return '$hour:$minute';
    }
  }
}

String _getStringFormat(int value) {
  return value.toString().length == 1 ? '0$value' : value.toString();
}
