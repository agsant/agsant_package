import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsDatePickerExamplePage extends StatefulWidget {
  const AgsDatePickerExamplePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AgsDatePickerExamplePageState();
}

class _AgsDatePickerExamplePageState extends State<AgsDatePickerExamplePage> {
  late final DateTime _minDate;
  late DateTime _selectedDate;
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    final currentDate = DateTime.now();
    _minDate = DateTime(
      currentDate.year - 4,
      currentDate.month,
      currentDate.day,
    );
    _selectedDate = _minDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText('Example Date Picker'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                readOnly: true,
                controller: textController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return AGSDatePicker(
                        title: 'Pilih Tanggal',
                        action: ElevatedButton(
                          onPressed: () {
                            textController.text = _selectedDate.stringFormat();
                          },
                          child: const Text('Selesai'),
                        ),
                        minDate: _minDate,
                        maxDate: DateTime.now(),
                        selectedDate: _selectedDate,
                        onSelectedItemChanged: (date) => _selectedDate = date,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
