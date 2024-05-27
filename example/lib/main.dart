import 'package:flutter/material.dart';

import 'src/load_local_image.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadLocalImage(),
    );
  }
}
