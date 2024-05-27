import 'package:load_local_image/load_local_image.dart';
import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../constants/assets.dart';

class AssetImageScreen extends StatelessWidget {
  const AssetImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asset Image",
          style: TextStyle(
            fontSize: 18.0,
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
              const Text(
                "Without Load Local Image",
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              const SizedBox(height: spacing),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(image_1),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(kRadialReactionRadius),
                  ),
                ),
              ),
              const SizedBox(height: bigSpacing),
              const Text(
                "With Load Local Image",
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              const SizedBox(height: spacing),
              Expanded(
                child: LoadLocalImage(
                  imageLoader: AssetImageLoader(imageProvider: const AssetImage(image_1)),
                  placeholder: const Center(child: CircularProgressIndicator(color: Colors.black)),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(image_1),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(kRadialReactionRadius),
                    ),
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
