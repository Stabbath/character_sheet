import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/component.dart';
import '../core/key_path_providers.dart';

class ImageWidget extends ConsumerWidget {
  final String id;
  final Provider<dynamic> imagePathProvider;

  ImageWidget({
    super.key,
    required this.id,
    required imageKeyPath,
  }) : imagePathProvider = getKeyPathProvider(imageKeyPath);

  factory ImageWidget.fromComponent(Component component) {
    return ImageWidget(
      id: component.id,
      imageKeyPath: component.dataBindings['path'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(imagePathProvider);

    return Image.asset(
      imagePath,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
    );
  }
}
