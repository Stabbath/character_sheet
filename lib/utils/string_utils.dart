String capitalizeWords(String str) => str.replaceAllMapped(RegExp(r'\b\w'), (match) => match.group(0)!.toUpperCase());

String underscoreToNormal(String str) => str.split('_').map(capitalizeWords).join(' ');
