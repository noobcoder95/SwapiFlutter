extension StringExt on String {
  String get initialCase {
    if(isEmpty) {
      return '-';
    }

    final List<String> list = split(' ');
    final List<String> result = [];
    for(var s in list) {
      if(s.isNotEmpty) {
        result.add(s[0].toUpperCase());
      }
    }

    return result.take(3).join(' ');
  }

  String get replaceIfEmpty => isEmpty ? '-' : this;
}