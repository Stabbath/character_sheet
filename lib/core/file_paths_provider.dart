import 'package:flutter_riverpod/flutter_riverpod.dart';

final filePathsProvider =
    StateNotifierProvider<FilePathsNotifier, FilePaths>((ref) {
  return FilePathsNotifier();
});

// Provider for file paths
class FilePathsNotifier extends StateNotifier<FilePaths> {
  FilePathsNotifier() : super(FilePaths(layoutPath: '', sheetPath: ''));

  void setPaths({required String layoutPath, required String sheetPath}) {
    state = FilePaths(layoutPath: layoutPath, sheetPath: sheetPath);
  }
}

class FilePaths {
  final String layoutPath;
  final String sheetPath;

  FilePaths({required this.layoutPath, required this.sheetPath});
}

