import 'package:intl/intl.dart';

String extractTime(String dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('hh:mm a').format(dateTime); // Format time as "06:12 AM"
  } catch (e) {
    return "Invalid Date"; // Handle invalid date formats
  }
}
