import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Emergency',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
/** */
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {
                // Action lorsque l'icône de profile est cliquée
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'assets/profile_image.jpg'), // Ajoutez le chemin de votre image de profil ici
            ),
            SizedBox(height: 20),
            Text(
              'Nom de l\'utilisateur',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 80),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text(
                      'Réglages',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Text(
                  'example@example.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 221, 27, 13), // Couleur du fond
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  // Action pour l'accueil
                },
                child: Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action pour les alertes
                },
                child: Text(
                  'Alert',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action pour les conseils
                },
                child: Text(
                  'Conseil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
