List<String> getMissingKeyPaths(Map<String, dynamic> data, List<List<String>> requiredKeyPaths) {
  List<String> missingKeyPaths = [];

  for (List<String> keyChain in requiredKeyPaths) {
    Map<String, dynamic>? current = data;
    String missingPath = "";

    for (int i = 0; i < keyChain.length; i++) {
      String key = keyChain[i];

      if (current == null || !current.containsKey(key) || current[key] == null) {
        // Build the full missing key-chain path as a string
        missingPath = (missingPath.isEmpty ? key : "$missingPath.$key");
        missingKeyPaths.add(missingPath);
        break;  // Stop checking deeper for this keyChain
      }

      // Append the key to the path and traverse deeper
      missingPath = (missingPath.isEmpty ? key : "$missingPath.$key");
      current = current[key] as Map<String, dynamic>?;
    }
  }

  return missingKeyPaths; // Will be empty if all key-chains are valid
}
