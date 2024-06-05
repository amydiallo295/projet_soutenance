import 'package:flutter/material.dart';

class EmergencyDetailPage extends StatelessWidget {
  final Map<String, dynamic> submission;

  const EmergencyDetailPage({required this.submission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Signalement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${submission['date']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Type: ${submission['type']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Lieu: ${submission['location']}',
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${submission['description']}',
            ),
            const SizedBox(height: 10),
            Text(
              'Statut: ${submission['status'] ? 'En cours' : 'Résolu'}',
            ),
            const SizedBox(height: 10),
            submission['imageUrl'] != null
                ? Image.network(submission['imageUrl'])
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
