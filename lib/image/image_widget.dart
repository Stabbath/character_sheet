import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'image_provider.dart';

class ImageWidget extends ConsumerWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(imageProvider);

    return Container(
      child: image.imagePath.isNotEmpty
        ? Image.asset(
          image.imagePath,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        )
        : const Icon(Icons.image_not_supported),
    );
  }
}
