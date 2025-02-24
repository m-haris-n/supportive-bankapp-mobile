import 'package:intl/intl.dart';

String extractTime(String dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('hh:mm a').format(dateTime); // Format time as "06:12 AM"
  } catch (e) {
    return "Invalid Date"; // Handle invalid date formats
  }
}

String? validatePassword(String password) {
  List<String> errors = [];

  if (password.length < 8) {
    errors.add("• Password must be at least 8 characters long");
  }
  if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
    errors.add("• Password must include at least one letter (A-Z, a-z)");
  }
  if (!RegExp(r'\d').hasMatch(password)) {
    errors.add("• Password must include at least one number (0-9)");
  }

  return errors.isEmpty ? null : errors.join("\n");
}
