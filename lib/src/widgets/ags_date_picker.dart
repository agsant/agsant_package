import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum _SelectorType { day, month, year }

class AGSDatePicker extends StatefulWidget {
  final void Function(DateTime) onSelectedItemChanged;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final TextStyle? disabledStyle;
  final Widget? selectionOverlay;
  final Color? backgroundColor;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? selectedDate;
  final EdgeInsetsGeometry? padding;
  final int height;
  final String? title;
  final ElevatedButton? action;

  const AGSDatePicker({
    super.key,
    required this.onSelectedItemChanged,
    this.minDate,
    this.maxDate,
    this.selectedDate,
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.backgroundColor,
    this.selectionOverlay,
    this.padding,
    this.height = 200,
    this.title,
    this.action,
  });

  @override
  State<StatefulWidget> createState() => _AGSDatePickerState();
}

class _AGSDatePickerState extends State<AGSDatePicker> {
  late DateTime _minDate;
  late DateTime _maxDate;
  late DateTime _selectedDate;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _yearScrollController;
  final _days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  late final _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  TextStyle? _selectedTextStyle;
  TextStyle? _disableTextStyle;
  TextStyle? _unselectedTextStyle;

  @override
  void initState() {
    super.initState();
    _initStyle();
    _validateDates();
    _dayScrollController = FixedExtentScrollController();
    _monthScrollController = FixedExtentScrollController();
    _yearScrollController = FixedExtentScrollController();
    _initDates();
  }

  @override
  void dispose() {
    _dayScrollController.dispose();
    _monthScrollController.dispose();
    _yearScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHeader(),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _monthSelector()),
                Expanded(child: _daySelector()),
                Expanded(child: _yearSelector()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHeader() {
    String title = widget.title ?? '';
    if (title.isEmpty && widget.action == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title ?? '',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          widget.action ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _initStyle() {
    _selectedTextStyle = widget.selectedStyle ??
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );

    _unselectedTextStyle = widget.unselectedStyle ??
        TextStyle(
          color: Colors.black.withOpacity(0.75),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );

    _disableTextStyle = widget.disabledStyle ??
        TextStyle(
          color: Colors.black.withOpacity(0.25),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
  }

  void _validateDates() {
    if (widget.minDate != null && widget.maxDate != null) {
      assert(!widget.minDate!.isAfter(widget.maxDate!));
    }
    if (widget.minDate != null && widget.selectedDate != null) {
      assert(!widget.minDate!.isAfter(widget.selectedDate!));
    }
    if (widget.maxDate != null && widget.selectedDate != null) {
      assert(!widget.selectedDate!.isAfter(widget.maxDate!));
    }
  }

  void _initDates() {
    final currentDate = DateTime.now();
    _minDate = widget.minDate ?? DateTime(currentDate.year - 3);
    _maxDate = widget.maxDate ?? DateTime.now();

    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    } else if (!currentDate.isBefore(_minDate) &&
        !currentDate.isAfter(_maxDate)) {
      _selectedDate = currentDate;
    } else {
      _selectedDate = _minDate;
    }

    _selectedDayIndex = _selectedDate.day - 1;
    _selectedMonthIndex = _selectedDate.month - 1;
    _selectedYearIndex = _selectedDate.year - _minDate.year;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollList(_dayScrollController, _selectedDayIndex);
        _scrollList(_monthScrollController, _selectedMonthIndex);
        _scrollList(_yearScrollController, _selectedYearIndex);
      },
    );
  }

  void _scrollList(FixedExtentScrollController controller, int index) {
    controller.animateToItem(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// check if selected year is a leap year
  bool _isLeapYear() {
    final year = _minDate.year + _selectedYearIndex;
    return year % 4 == 0 &&
        (year % 100 != 0 || (year % 100 == 0 && year % 400 == 0));
  }

  /// get number of days for the selected month
  int _numberOfDays() {
    if (_selectedMonthIndex == 1) {
      _days[1] = _isLeapYear() ? 29 : 28;
    }
    return _days[_selectedMonthIndex];
  }

  void _onSelectedItemChanged(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }

    // return if selected date is not the min - max date range
    // scroll selector back to the valid point
    if (temp.isBefore(_minDate) || temp.isAfter(_maxDate)) {
      switch (type) {
        case _SelectorType.day:
          _dayScrollController.jumpToItem(_selectedDayIndex);
          break;
        case _SelectorType.month:
          _monthScrollController.jumpToItem(_selectedMonthIndex);
          break;
        case _SelectorType.year:
          _yearScrollController.jumpToItem(_selectedYearIndex);
          break;
      }
      return;
    }
    // update selected date
    _selectedDate = temp;
    // adjust other selectors when one selctor is changed
    switch (type) {
      case _SelectorType.day:
        _selectedDayIndex = index;
        break;
      case _SelectorType.month:
        _selectedMonthIndex = index;
        // if month is changed to february &
        // selected day is greater than 29,
        // set the selected day to february 29 for leap year
        // else to february 28
        if (_selectedMonthIndex == 1 && _selectedDayIndex > 27) {
          _selectedDayIndex = _isLeapYear() ? 28 : 27;
        }
        // if selected day is 31 but current selected month has only
        // 30 days, set selected day to 30
        if (_selectedDayIndex == 30 && _days[_selectedMonthIndex] == 30) {
          _selectedDayIndex = 29;
        }
        break;
      case _SelectorType.year:
        _selectedYearIndex = index;
        // if selected month is february & selected day is 29
        // But now year is changed to non-leap year
        // set the day to february 28
        if (!_isLeapYear() &&
            _selectedMonthIndex == 1 &&
            _selectedDayIndex == 28) {
          _selectedDayIndex = 27;
        }
        break;
    }
    setState(() {});
    widget.onSelectedItemChanged(_selectedDate);
  }

  /// check if the given day, month or year index is disabled
  bool _isDisabled(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
        );
        break;
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
    }
    return temp.isAfter(_maxDate) || temp.isBefore(_minDate);
  }

  Widget _selector({
    required List<dynamic> values,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
    required void Function(int) onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker.builder(
      childCount: values.length,
      itemExtent: 40,
      useMagnifier: true,
      diameterRatio: 2,
      scrollController: scrollController,
      backgroundColor: widget.backgroundColor,
      selectionOverlay: widget.selectionOverlay ??
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (context, index) => Container(
        height: 40,
        alignment: Alignment.center,
        child: Text(
          '${values[index]}',
          style: index == selectedValueIndex
              ? _selectedTextStyle
              : isDisabled(index)
                  ? _disableTextStyle
                  : _unselectedTextStyle,
        ),
      ),
    );
  }

  Widget _daySelector() {
    return _selector(
      values: List.generate(_numberOfDays(), (index) => index + 1),
      selectedValueIndex: _selectedDayIndex,
      scrollController: _dayScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.day),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.day,
      ),
    );
  }

  Widget _monthSelector() {
    return _selector(
      values: _months,
      selectedValueIndex: _selectedMonthIndex,
      scrollController: _monthScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.month),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.month,
      ),
    );
  }

  Widget _yearSelector() {
    return _selector(
      values: List.generate(
        _maxDate.year - _minDate.year + 1,
        (index) => _minDate.year + index,
      ),
      selectedValueIndex: _selectedYearIndex,
      scrollController: _yearScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.year),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.year,
      ),
    );
  }
}
