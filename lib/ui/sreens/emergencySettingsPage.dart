import 'package:emergency/ui/sreens/emergencyProfilePage.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage2()),
                );
                // Action pour mettre à jour les informations de profil
              },
              child: Text('Modifier le profil'),
            ),
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
            SizedBox(height: 20),
            Text(
              'Politique de confidentialité et conditions d\'utilisation',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
            ),
/**            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action pour afficher la politique de confidentialité et les conditions d'utilisation
              },
              child: Text('Afficher'),
            ), */
            
          ],
        ),
      ),
    );
  }
}
