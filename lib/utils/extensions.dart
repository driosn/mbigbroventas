extension DateTimeX on DateTime {
  String get slashedDate {
    return "${year.toString().padLeft(4, '0')}/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}";
  }

  String get reversedSlashedDate {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString().padLeft(4, '0')}";
  }

  String get dashedDate {
    return "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}

extension Validations on String {
  bool alphaIsOk() {
    final validCharacters = RegExp(r'^[a-zA-Z]+$');
    return validCharacters.hasMatch(this);
  }

  bool alphaIsOkWithSpaces() {
    final validCharacters = RegExp(r'^[a-zA-Z ]+$');
    return validCharacters.hasMatch(this);
  }
}
