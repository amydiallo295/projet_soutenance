import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatDateFromTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}

class NoDataWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const NoDataWidget({
    super.key,
    this.message = "Aucune donnée disponible",
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
