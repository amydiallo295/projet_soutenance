import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Espace pour le logo de l'application
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Bienvenue dans l\'application de signalement d\'urgence',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Appuyez sur un bouton ci-dessous pour signaler une urgence.',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 400, // Ajustez la hauteur en fonction de votre logo
                  width: 500,
                  child: Image.asset(
                      'assets/images/emergencylogo.png'), // Assurez-vous que le logo est dans le dossier assets
                ),
                SizedBox(height: 0),
              ],
            ),
          ),

          // Espace flexible pour centrer les boutons verticalement
          ElevatedButton.icon(
            icon: Icon(Icons.local_fire_department, size: 40),
            label: Text(
              'Signaler un incendie',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton
            },
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.local_hospital, size: 40),
            label: Text(
              'Signaler un accident',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton
            },
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.report_problem, size: 40),
            label: Text(
              'Signaler une autre urgence',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.orangeAccent,
            ),
            onPressed: () {
              // Action à effectuer lors de l'appui sur le bouton
            },
          ),
          Spacer(), // Espace flexible pour centrer les boutons verticalement
        ],
      ),
    );
  }
}
