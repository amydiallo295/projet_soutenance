import 'package:emergency/ui/sreens/emergencySettingsPage.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ElevatedButton.icon(
        onPressed: () {
          // Action pour se déconnecter
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        label: const Text(
          'Se déconnecter',
          style: TextStyle(color: Color.fromARGB(255, 174, 170, 169)),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: const Column(
              children: [
                // Icone de profil
                verticalSpaceMedium,
                CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Nom de l'utilisateur
                Text(
                  'Nom de l\'utilisateur',
                  style: TextStyle(
                    fontSize: 18,
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
