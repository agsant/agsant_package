import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsCheckboxPage extends StatefulWidget {
  const AgsCheckboxPage({super.key});

  @override
  State<StatefulWidget> createState() => _AgsCheckboxPageState();
}

class _AgsCheckboxPageState extends State<AgsCheckboxPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return AgsPage(
      title: 'Checkbox',
      iconTheme: const IconThemeData(color: AgsColor.white),
      child: Center(
        child: Row(
          children: [
            AgsCheckbox(
              value: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            Expanded(
              child: AgsText('Checkbox'),
            ),
          ],
        ),
      ),
    );
  }
}
