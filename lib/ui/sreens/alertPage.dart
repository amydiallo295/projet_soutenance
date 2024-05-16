import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AlertPage extends StatelessWidget {
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade900, Colors.black],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logoApp.png', // Ajoutez le chemin de votre image ici
                              width:
                                  200, // Ajustez la largeur selon votre besoin
                            ),
                            SizedBox(
                                height:
                                    20), // Espace vertical entre l'image et le texte
                            Text(
                              "Cliquer sur ce bouton pour emmettre une alerte d'urgence",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              10.0), // Augmenter la taille du padding
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                // Action pour le bouton
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 221, 27, 13), // Couleur du bouton
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(50)

                                  // Forme du bouton en cercle
                                  ),
                              child: Text(
                                'Signaler',
                                style: TextStyle(
                                  color: Colors
                                      .white, // Couleur du texte du bouton
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
