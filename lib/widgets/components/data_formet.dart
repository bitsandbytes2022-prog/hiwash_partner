
import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return '';
  }

  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('d MMM yyyy').format(dateTime);


}



String formatServerDate(String serverDate) {
  try {
    DateTime parsedDate = DateTime.parse(serverDate);

    final DateFormat formatter = DateFormat('dd-MMM-yyyy / hh:mm a');

    return formatter.format(parsedDate);
  } catch (e) {
    return serverDate;
  }
}