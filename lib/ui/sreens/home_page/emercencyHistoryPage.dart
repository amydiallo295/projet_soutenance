import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(text: "Historique des Signalements"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHistoryItem(
                date: '20 Mai 2023',
                type: 'Feu',
                location: '123 Rue de Paris',
                status: 'En cours',
              ),
              const SizedBox(height: 10),
              _buildHistoryItem(
                date: '15 Avril 2023',
                type: 'Accident de voiture',
                location: 'Avenue Charles de Gaulle',
                status: 'Résolu',
              ),
              const SizedBox(height: 10),
              _buildHistoryItem(
                date: '10 Mars 2023',
                type: 'Urgence médicale',
                location: 'Hôpital Saint-Louis',
                status: 'En cours',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
      {required String date,
      required String type,
      required String location,
      required String status}) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Type: $type',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text('Lieu: $location'),
            Text('Statut: $status'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Action pour voir les détails du signalement
        },
      ),
    );
  }
}
