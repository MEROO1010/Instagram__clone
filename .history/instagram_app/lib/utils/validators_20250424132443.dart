class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6)
      return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.length < 3) return 'Username too short';
    return null;
  }
}
