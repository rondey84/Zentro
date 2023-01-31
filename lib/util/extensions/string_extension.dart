extension StringExtension on String {
  bool? parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    } else {
      return null;
    }
  }
}
