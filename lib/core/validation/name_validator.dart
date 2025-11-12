//? Name validation utility (for first and last names)
class NameValidator {
  //* Validate name (letters only)
  static bool isValid(String name) {
    if (name.isEmpty) return false;

    //* Only letters and spaces allowed
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);
  }

  static String? validate(String? name, String fieldName) {
    if (name == null || name.isEmpty) {
      return '$fieldName is required';
    }

    if (!isValid(name)) {
      return '$fieldName can only contain letters';
    }

    return null;
  }
}

