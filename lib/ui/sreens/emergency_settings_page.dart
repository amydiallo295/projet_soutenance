import 'package:emergency/ui/sreens/politique_confidentialite.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Mettre à jour les informations de profil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'Options de notification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Mises à jour'),
              value: true, // Mettez la valeur actuelle de la notification ici
              onChanged: (bool value) {
                // Action pour activer/désactiver les notifications de mises à jour
              },
            ),
            SwitchListTile(
              title: const Text('Confirmations de signalement'),
              value: false, // Mettez la valeur actuelle de la notification ici
              onChanged: (bool value) {
                // Action pour activer/désactiver les notifications de confirmation de signalement
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage()));

                // Action pour les conseils
              },
              child: const Text(
                'Politique de confidentialité et conditions d\'utilisation',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
