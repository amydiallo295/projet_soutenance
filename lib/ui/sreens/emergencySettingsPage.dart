import 'package:emergency/ui/sreens/politiqueConfidentialit%C3%A9.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mettre à jour les informations de profil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            Text(
              'Options de notification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text('Mises à jour'),
              value: true, // Mettez la valeur actuelle de la notification ici
              onChanged: (bool value) {
                // Action pour activer/désactiver les notifications de mises à jour
              },
            ),
            SwitchListTile(
              title: Text('Confirmations de signalement'),
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
                        builder: (context) => PrivacyPolicyPage()));

                // Action pour les conseils
              },
              child: Text(
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
