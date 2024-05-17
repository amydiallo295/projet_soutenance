import 'package:emergency/ui/sreens/reportPage.dart';
import 'package:emergency/ui/sreens/emergencyallPage.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {
  const AccueilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: TitleWidget(
            text: "Emergency",
          )),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    height: 100, // Ajustez la hauteur en fonction de votre logo
                    width: 300,
                    child: Image.asset(
                      'assets/images/emergencylogo.png',
                      fit: BoxFit.cover,
                    ), // Assurez-vous que le logo est dans le dossier assets
                  ),
                ],
              ),
            ),
            verticalSpaceLarge,
            ButtonWidget(
              color: Colors.redAccent,
              label: "Signaler une urgence ",
              icon: Icons.report_problem,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyReportPage()),
                );
              },
            ),
            verticalSpaceSmall,
            ButtonWidget(
              color: Colors.orangeAccent,
              label: "Appeler un service",
              icon: Icons.phone,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyCallPage()),
                );
              },
            ),
            verticalSpaceSmall,
            ButtonWidget(
                color: Colors.orangeAccent,
                label: "Signaler une autre urgence",
                icon: Icons.report_sharp,
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
