import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsImageExamplePage extends StatelessWidget {
  const AgsImageExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgsText('Example Ags Text'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _getImageNetwork('https://picsum.photos/600'),
            _getImageNetwork('https://picsum.photos/600/300'),
            _getImageNetwork('https://picsum.photos-s/600/300'),
            _getImageAsset('assets/images/example_image.png'),
          ],
        ),
      ),
    );
  }

  Widget _getImageNetwork(String url) {
    return AgsImage(
      url,
      type: AgsImageType.network,
      fit: BoxFit.contain,
      cornerRadius: 12,
    );
  }

  Widget _getImageAsset(String url) {
    return AgsImage(
      url,
      type: AgsImageType.asset,
    );
  }
}
