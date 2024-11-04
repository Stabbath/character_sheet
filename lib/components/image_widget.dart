import 'dart:io';

import 'package:character_sheet/core/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';

import '../core/providers/providers.dart';

class ImageWidget extends Component {
  const ImageWidget({
    super.key,
    required super.definition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(sheetDataProvider.select((state) => state?.get(definition.sourceKeys['path']!)));

    final imagePathUpdater = ref.read(sheetDataProvider.notifier).getUpdater(definition.sourceKeys['path']!);

    final File imageFile = File(imagePath);

    return Stack(
      children: [
        // Main Image Display
        Positioned.fill(
          child: imagePath != null && imagePath.isNotEmpty && imageFile.existsSync()
          ? Image.file(
            imageFile,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error));
            },
          )
          : const Center(child: Icon(Icons.error)),
        ),

        // Discreet Edit Button at the Top Right
        Positioned(
          top: 8.0,
          right: 8.0,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.black54),
            tooltip: 'Change Image',
            onPressed: () async {
              final XFile? file = await openFile(
                acceptedTypeGroups: [XTypeGroup(extensions: ['jpg', 'png'])],
              );
              if (file != null) {
                imagePathUpdater(file.path);
              }
            },
          ),
        ),
      ],
    );
  }
}