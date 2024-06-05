import 'package:intl/intl.dart';

formatDateFromFirebase(date) {
  DateTime firebaseDate = DateTime.parse(date);
  return DateFormat('dd/MM/yyyy').format(firebaseDate);
}
