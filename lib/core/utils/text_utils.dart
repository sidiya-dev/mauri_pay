/// Capitalizes the first letter of each word, lower-casing the rest.
/// "mohamed  el-amin" -> "Mohamed El-amin". Used for names before sending them
/// to the backend so they're stored consistently.
String capitalizeWords(String input) {
  return input
      .trim()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join(' ');
}
