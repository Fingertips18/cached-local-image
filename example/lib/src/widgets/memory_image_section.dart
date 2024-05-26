import 'package:load_local_image/load_local_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/dimensions.dart';
import '../constants/assets.dart';

class MemoryImageSection extends StatelessWidget {
  const MemoryImageSection({super.key});

  Future<Uint8List> _getMemoryImage() async {
    final bytes = await rootBundle.load(image_3);

    return bytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          "Memory Image",
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
        FutureBuilder(
          future: _getMemoryImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: size.height / 3.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(kRadialReactionRadius),
                        ),
                      ),
                    ),
                    const SizedBox(width: spacing),
                    Expanded(
                      child: LoadLocalImage(
                        imageLoader: MemoryImageLoader(
                          imageProvider: MemoryImage(snapshot.data!),
                        ),
                        placeholder: const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                        child: Container(
                          height: size.height / 3.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(kRadialReactionRadius),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No file image"));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Fetching File Image"));
            } else {
              return const Center(child: Text("Error fetching file image"));
            }
          },
        ),
      ],
    );
  }
}
