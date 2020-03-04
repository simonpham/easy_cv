class RegexUtils {
  static const Pattern email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// contains only alphanumeric, dot & space character
  static const Pattern name = r'^[a-zA-Z0-9. ]*$';

  /// begin with one letter, contains only alphanumeric
  /// and only one dot or underscore in a row (not accept at the end)
  static const Pattern username = r'^[a-zA-Z](?:[_.]?[a-zA-Z0-9]+)*$';

  /// contains only alphanumeric
  /// with selected special character & length from 6-25
  static const Pattern password = r'^[a-zA-Z0-9.\-_!@#$%]{6,25}$';

  static bool check(String text, Pattern pattern) {
    return RegExp(pattern).hasMatch(text);
  }
}
