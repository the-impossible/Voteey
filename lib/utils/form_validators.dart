class FormValidator {
  static String? validateRegNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Valid RegNo is Required!';
    }
    return null;
  }

    static String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return 'Position is Required!';
    }
    return null;
  }

 }

