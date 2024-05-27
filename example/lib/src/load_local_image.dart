import 'package:flutter/material.dart';
import 'constants/dimensions.dart';

import 'screens/memory_image_screen.dart';
import 'screens/asset_image_screen.dart';
import 'screens/file_image_screen.dart';
import 'widgets/custom_button.dart';

class LoadLocalImage extends StatelessWidget {
  const LoadLocalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Load Local Image",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: "Asset Image",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AssetImageScreen();
                    },
                  ),
                ),
              ),
              const SizedBox(height: bigSpacing),
              CustomButton(
                label: "File Image",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FileImageScreen();
                    },
                  ),
                ),
              ),
              const SizedBox(height: bigSpacing),
              CustomButton(
                label: "Memory Image",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MemoryImageScreen();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
