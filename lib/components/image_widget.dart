import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';

import '../core/data_bindings.dart';
import '../core/layout/component.dart';
import '../core/providers.dart';

class ImageWidget extends ConsumerWidget {
  final String id;
  final DataBinding dataBinding;

  const ImageWidget({
    super.key,
    required this.id,
    required this.dataBinding,
  });

  factory ImageWidget.fromComponent(Component component) {
    return ImageWidget(
      id: component.id,
      dataBinding: component.dataBindings['path'],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(sheetDataProvider.select((state) => state != null ? dataBinding.getInSheet(state) : null));
    final updater = dataBinding.createStateUpdater(ref.read(sheetDataProvider.notifier));
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
                updater(file.path);
              }
            },
          ),
        ),
      ],
    );
  }
}