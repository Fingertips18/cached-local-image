import 'package:load_local_image/load_local_image.dart';
import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../constants/dimensions.dart';

class AssetImageSection extends StatelessWidget {
  const AssetImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          "Asset Image",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: spacing),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                "Without Load Local Image",
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                "With Load Local Image",
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: size.height / 3.0,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(image_1),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(kRadialReactionRadius),
                ),
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: LoadLocalImage(
                imageLoader: AssetImageLoader(
                  imageProvider: const AssetImage(image_1),
                ),
                placeholder: const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
                child: Container(
                  height: size.height / 3.0,
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
      ],
    );
  }
}
