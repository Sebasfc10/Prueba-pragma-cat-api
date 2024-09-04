import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeImageView extends StatelessWidget {
  final String imageUrl;

  const NativeImageView({Key? key, required this.imageUrl}) : super(key: key);

Future<void> _testPlatformChannel() async {
  const platform = MethodChannel('native-image-view');
  try {
    final String result = await platform.invokeMethod('test');
    print('Native response: $result');
  } on PlatformException catch (e) {
    print("Failed to invoke: '${e.message}'.");
  }
}


  @override
  Widget build(BuildContext context) {
    _testPlatformChannel();
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'native-image-view',
        creationParams: {'imageUrl': imageUrl},
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'native-image-view',
        creationParams: {'imageUrl': imageUrl},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('Unsupported platform');
  }
}
