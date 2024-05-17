import 'package:emergency/ui/sreens/emergencySettingsPage.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ElevatedButton.icon(
        onPressed: () {
          // Action pour se déconnecter
        },
        icon: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        label: Text(
          'Se déconnecter',
          style: TextStyle(color: Colors.red),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text('Profil Utilisateur'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                // Icone de profil
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Nom de l'utilisateur
                Text(
                  'Nom de l\'utilisateur',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Biographie de l'utilisateur
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          // Options
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () {
              // Action pour aller à la page des paramètres
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Historique'),
            onTap: () {
              // Action pour aller à la page des paramètres
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Politique de confidentialité'),
            onTap: () {
              // Action pour afficher la politique de confidentialité
            },
          ),
        ],
      ),
    );
  }
}
