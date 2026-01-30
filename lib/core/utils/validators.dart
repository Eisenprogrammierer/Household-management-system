// household-management-system/lib/core/utils/validators.dart

class Validators {
  static bool isValidEmail(String email) =>
    RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);

  static bool isNotEmpty(String? value) =>
    value != null && value.trim().isNotEmpty;

  static bool isValidPassword(String password) =>
    password.length >= 8 &&
    RegExp(r'[A-Z]').hasMatch(password) &&
    RegExp(r'[0-9]').hasMatch(password);

  static bool isValidNumber(String value) =>
    RegExp(r'^[0-9]+$').hasMatch(value);
}
