/// Format price in Cambodian Riel (៛)
String formatPriceRiel(double price) {
  final n = price.toInt();
  if (n >= 1000) {
    final k = n ~/ 1000;
    final r = n % 1000;
    return r > 0 ? '$k,${r.toString().padLeft(3, '0')}៛' : '$k,000៛';
  }
  return '$n៛';
}
