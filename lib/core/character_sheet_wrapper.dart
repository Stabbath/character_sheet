import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'character_sheet_widget.dart';
import 'providers.dart';

class CharacterSheetWrapper extends ConsumerStatefulWidget {
  const CharacterSheetWrapper({super.key});

  @override
  CharacterSheetWrapperState createState() => CharacterSheetWrapperState();
}

class CharacterSheetWrapperState extends ConsumerState<CharacterSheetWrapper> {
  Future<void>? _initializationFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ensure init only happens once
    _initializationFuture ??= initializeProviders(ProviderScope.containerOf(context));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              throw(snapshot.error, snapshot.stackTrace);
            }
            return Scaffold(
              body: Center(
                child: Text('Error loading data: ${snapshot.error}'),
              ),
            );
          } else {
            return CharacterSheet();
          }
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
