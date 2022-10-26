import 'package:flutter_show/util/regex_utils.dart';

extension StringExtension on String {


  String get paramSymbol {
    if (contains('?')) {
      return '&';
    }
    return '?';
  }


  bool get hasOnlyWhitespaces => trim().isEmpty && isNotEmpty;

  bool get isListView => this != 'horizontal';

  bool get isEmptyOrNull {
    // ignore: unnecessary_null_comparison
    if (this == null) {
      return true;
    }
    return isEmpty;
  }

  String toSpaceSeparated() {
    final value =
    replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    return value;
  }

  String formatCopy() {
    return replaceAll('},', '\n},\n')
        .replaceAll('[{', '[\n{\n')
        .replaceAll(',"', ',\n"')
        .replaceAll('{"', '{\n"')
        .replaceAll('}]', '\n}\n]');
  }

  bool get isNoInternetError => contains('SocketException: Failed host lookup');

  bool get isURLImage => isNotEmpty && (contains('http') || contains('https'));

  Uri? toUri() => Uri.tryParse(this);

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String upperCaseFirstChar() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.upperCaseFirstChar())
      .join(' ');

  bool get isEmail => validateEmail();

  bool validateEmail() {
    final copy = this;
    if (copy == null || copy.isEmpty) {
      return false;
    }
    return RegexUtils.check(copy, RegexUtils.email);
  }
}
