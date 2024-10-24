import 'dart:io';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsCameraExamplePage extends StatefulWidget {
  const AgsCameraExamplePage({super.key});

  @override
  State<StatefulWidget> createState() => _AgsCameraExamplePageState();
}

class _AgsCameraExamplePageState extends State<AgsCameraExamplePage> {
  String? _path;

  @override
  Widget build(BuildContext context) {
    return AgsPage(
      title: 'Camera Example',
      child: SingleChildScrollView(
        child: Column(
          children: [
            _imageWidget(),
            const SizedBox(height: 20),
            AgsButton(
              title: 'Capture',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgsCamera(
                      isSquare: true,
                      onSave: (path) {
                        setState(() {
                          _path = path;
                        });
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    String? path = _path;
    if (path == null) {
      return const SizedBox.shrink();
    }

    return Image.file(
      height: 320,
      fit: BoxFit.fitHeight,
      File(path),
    );
  }
}
