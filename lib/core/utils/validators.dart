/// validators.dart
/// Common validation functions for forms (login, register, etc.)
/// All functions return `null` if valid, or an error message string if invalid.

class Validators {
  // -----------------------
  // Basic required field
  // -----------------------
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'សូមបំពេញព័ត៌មាននេះ';
    }
    return null;
  }

  // -----------------------
  // Email validation
  // -----------------------
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'សូមបញ្ចូលអ៊ីមែល';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'អ៊ីមែលមិនត្រឹមត្រូវ';
    }

    return null;
  }

  // -----------------------
  // Password validation
  // -----------------------
  static String? password(
    String? value, {
    int minLength = 6,
    bool requireUppercase = false,
    bool requireNumber = false,
    bool requireSpecialChar = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'សូមបញ្ចូលពាក្យសម្ងាត់';
    }

    if (value.length < minLength) {
      return 'ពាក្យសម្ងាត់ត្រូវតែមានយ៉ាងហោចណាស់ $minLength តួអក្សរ';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return 'ត្រូវមានអក្សរធំយ៉ាងហោចណាស់មួយ';
    }

    if (requireNumber && !RegExp(r'[0-9]').hasMatch(value)) {
      return 'ត្រូវមានលេខយ៉ាងហោចណាស់មួយ';
    }

    if (requireSpecialChar && !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'ត្រូវមានអក្សរពិសេសយ៉ាងហោចណាស់មួយ';
    }

    return null;
  }

  // -----------------------
  // Confirm password match
  // -----------------------
  static String? confirmPassword(
    String? confirmValue,
    String? originalPassword, {
    String? message,
  }) {
    if (confirmValue == null || confirmValue.isEmpty) {
      return 'សូមបញ្ជាក់ពាក្យសម្ងាត់';
    }

    if (confirmValue != originalPassword) {
      return message ?? 'ពាក្យសម្ងាត់មិនដូចគ្នា';
    }

    return null;
  }

  // -----------------------
  // Cambodian phone number (simple check)
  // Supports: 0xx xxx xxx, +855 xx xxx xxx
  // -----------------------
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'សូមបញ្ចូលលេខទូរស័ព្ទ';
    }

    // Remove spaces, dashes, etc.
    final cleaned = value.replaceAll(RegExp(r'[\s\-+]'), '');

    // Common Cambodian patterns
    if (cleaned.startsWith('0') && cleaned.length == 10) {
      // 0xx xxx xxx
      return null;
    }
    if (cleaned.startsWith('855') && cleaned.length == 12) {
      // +855 xx xxx xxx without +
      return null;
    }

    return 'លេខទូរស័ព្ទមិនត្រឹមត្រូវ (ឧ. 012 345 678)';
  }

  // -----------------------
  // Full name (at least 2 words or reasonable length)
  // -----------------------
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'សូមបញ្ចូលឈ្មោះពេញ';
    }

    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'ឈ្មោះខ្លីពេក';
    }

    // Optional: check for at least one space (first + last name)
    // if (!trimmed.contains(' ')) {
    //   return 'សូមបញ្ចូលឈ្មោះ និងនាមត្រកូល';
    // }

    return null;
  }
}