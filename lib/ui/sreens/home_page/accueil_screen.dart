import 'package:emergency/ui/sreens/InformationPage.dart';
import 'package:emergency/ui/sreens/emergencyallPage.dart';
import 'package:emergency/ui/sreens/helpage.dart';
import 'package:emergency/ui/sreens/reportPage.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(text: "EMERCENCY"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Action pour les notifications
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppBarColor,
                //  Colors.orangeAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // Nombre de colonnes
            crossAxisSpacing: 16.0, // Espacement entre les colonnes
            mainAxisSpacing: 16.0, // Espacement entre les lignes
            children: [
              _buildDashboardItem(
                context,
                color: Colors.redAccent,
                icon: Icons.report_problem,
                label: "Signaler une urgence",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencySubmissionPage(),
                      //  EmergencyReportPage(),
                    ),
                  );
                },
              ),
              _buildDashboardItem(
                context,
                color: Colors.orangeAccent,
                icon: Icons.phone,
                label: "Appeler un service",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyCallPage(),
                    ),
                  );
                },
              ),
              _buildDashboardItem(
                context,
                color: Colors.tealAccent,
                icon: Icons.help,
                label: "Conseils",
                onTap: () {
                  // Action pour obtenir de l'aide

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdvicePage(),
                    ),
                  );
                },
              ),
              // _buildDashboardItem(
              //   context,
              //   color: Colors.blueAccent,
              //   icon: Icons.history,
              //   label: "Historique",
              //   onTap: () {
              //     // Action pour voir l'historique
              //   },
              // ),
              _buildDashboardItem(
                context,
                color: Colors.greenAccent,
                icon: Icons.info,
                label: "À propos",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ),
                  );
                },
              ),
              // _buildDashboardItem(
              //   context,
              //   color: Colors.purpleAccent,
              //   icon: Icons.info,
              //   label: "À propos",
              //   onTap: () {
              //     // Action pour afficher les informations sur l'application
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30.0),
            const SizedBox(height: 10.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}







//  padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Text(
//                   'Bienvenue dans l\'application de signalement d\'urgence',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Appuyez sur un bouton ci-dessous pour signaler une urgence.',
//                   style: TextStyle(
//                     fontSize: 13,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 400, // Ajustez la hauteur en fonction de votre logo
//                   width: 500,
//                   child: Image.asset(
//                       'assets/images/emergencylogo.png'), // Assurez-vous que le logo est dans le dossier assets
//                 ),
//               ],
//             ),
//           ),
