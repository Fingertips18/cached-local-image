import 'package:flutter/material.dart';

import 'widgets/memory_image_section.dart';
import 'widgets/asset_image_section.dart';
import 'widgets/file_image_section.dart';
import 'constants/dimensions.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                AssetImageSection(),
                SizedBox(height: bigSpacing),
                FileImageSection(),
                SizedBox(height: bigSpacing),
                MemoryImageSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
