import 'package:emergency/ui/sreens/InformationPage.dart';
import 'package:emergency/ui/sreens/emergencyallPage.dart';
import 'package:emergency/ui/sreens/reportPage.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
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
                Colors.redAccent,
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
                label: "Infos",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InformationPage(),
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
              _buildDashboardItem(
                context,
                color: Colors.tealAccent,
                icon: Icons.help,
                label: "Aide",
                onTap: () {
                  // Action pour obtenir de l'aide
                },
              ),
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

// class TitleWidgetGrid extends StatelessWidget {
//   final String text;

//   const TitleWidgetGrid({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }
