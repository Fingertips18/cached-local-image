import 'package:load_local_image/load_local_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/dimensions.dart';
import '../constants/assets.dart';

class MemoryImageScreen extends StatefulWidget {
  const MemoryImageScreen({super.key});

  @override
  State<MemoryImageScreen> createState() => _MemoryImageScreenState();
}

class _MemoryImageScreenState extends State<MemoryImageScreen> {
  late final Future<Uint8List> _future;

  @override
  void initState() {
    super.initState();

    _future = _getMemoryImage();
  }

  Future<Uint8List> _getMemoryImage() async {
    final bytes = await rootBundle.load(image_3);

    return bytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Memory Image",
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
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
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
                            image: DecorationImage(
                              image: MemoryImage(snapshot.data!),
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
                          imageLoader: MemoryImageLoader(imageProvider: MemoryImage(snapshot.data!)),
                          placeholder: const Center(
                            child: CircularProgressIndicator(color: Colors.black),
                          ),
                          child: Container(
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
                  return const Center(child: Text("No memory image"));
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Fetching memory image..."));
              } else {
                return const Center(child: Text("Error fetching memory image"));
              }
            },
          ),
        ),
      ),
    );
  }
}
