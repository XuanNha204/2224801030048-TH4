String extractFirstImageUrl(String html) {
  final match = RegExp(
    r'''(?:src|data-src)\s*=\s*["']([^"']+)["']''',
    caseSensitive: false,
  ).firstMatch(html);
  return decodeHtmlEntities(match?.group(1)?.trim() ?? '');
}

String plainTextFromHtml(String html) {
  var value = html
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]*>', multiLine: true), ' ');
  value = decodeHtmlEntities(value);
  return value
      .replaceAll(RegExp(r'[ \t]+'), ' ')
      .replaceAll(RegExp(r'\s*\n\s*'), '\n')
      .replaceAll(RegExp(r'\n{2,}'), '\n')
      .trim();
}

String decodeHtmlEntities(String value) {
  const named = <String, String>{
    '&amp;': '&',
    '&quot;': '"',
    '&#39;': "'",
    '&apos;': "'",
    '&lt;': '<',
    '&gt;': '>',
    '&nbsp;': ' ',
  };

  var decoded = value;
  named.forEach((entity, replacement) {
    decoded = decoded.replaceAll(entity, replacement);
  });

  return decoded.replaceAllMapped(RegExp(r'&#(x?[0-9a-fA-F]+);'), (match) {
    final raw = match.group(1)!;
    final radix = raw.startsWith('x') ? 16 : 10;
    final digits = raw.startsWith('x') ? raw.substring(1) : raw;
    final codePoint = int.tryParse(digits, radix: radix);
    return codePoint == null ? match.group(0)! : String.fromCharCode(codePoint);
  });
}
