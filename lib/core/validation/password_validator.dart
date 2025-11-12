import 'package:workiom_task/features/auth/data/model/auth_models.dart';

//? Password validation utility
class PasswordValidator {
  //* Validate password based on complexity requirements
  static Map<String, bool> validatePassword(
    String password,
    PasswordComplexityModel complexity,
  ) {
    return {
      'length': password.length >= complexity.requiredLength,
      'digit': !complexity.requireDigit || password.contains(RegExp(r'\d')),
      'lowercase': !complexity.requireLowercase || password.contains(RegExp(r'[a-z]')),
      'uppercase': !complexity.requireUppercase || password.contains(RegExp(r'[A-Z]')),
      'special': !complexity.requireNonAlphanumeric ||
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    };
  }

  //* Check if password meets all requirements
  static bool isPasswordValid(
    String password,
    PasswordComplexityModel complexity,
  ) {
    final validation = validatePassword(password, complexity);
    return validation.values.every((isValid) => isValid);
  }

  //* Calculate password strength (0.0 to 1.0)
  static double calculateStrength(
    String password,
    PasswordComplexityModel complexity,
  ) {
    if (password.isEmpty) return 0.0;

    final validation = validatePassword(password, complexity);
    final metRequirements = validation.values.where((v) => v).length;
    final totalRequirements = validation.length;

    return metRequirements / totalRequirements;
  }

  //* Get password strength text
  static String getStrengthText(double strength) {
    if (strength < 0.4) return 'Weak';
    if (strength < 0.7) return 'Medium';
    if (strength >= 1.0) return 'Strong';
    return 'Not enough strong';
  }
}

