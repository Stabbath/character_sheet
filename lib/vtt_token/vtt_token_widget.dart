import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vtt_token_provider.dart';

class VttTokenWidget extends ConsumerWidget {
  const VttTokenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vttToken = ref.watch(vttTokenProvider);

    return Container(
      child: vttToken.imagePath.isNotEmpty
        ? Image.asset(
          vttToken.imagePath,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: const Icon(Icons.error));
          },
        )
        : const Icon(Icons.image_not_supported),
    );
  }
}
