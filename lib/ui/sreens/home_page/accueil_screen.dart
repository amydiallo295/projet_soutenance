// import 'package:emergency/routers/routes.dart';
// import 'package:emergency/utils/app_colors.dart';
// import 'package:emergency/utils/ui_helpers.dart';
// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: TitleWidget(text: "EMERCENCY"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {
//               // Action pour les notifications
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: GridView.count(
//             crossAxisCount: 2, // Nombre de colonnes
//             crossAxisSpacing: 16.0, // Espacement entre les colonnes
//             mainAxisSpacing: 16.0, // Espacement entre les lignes
//             children: [
//               _buildDashboardItem(
//                 context,
//                 color: Colors.redAccent,
//                 icon: Icons.report_problem,
//                 label: "Signaler une urgence",
//                 onTap: () {
//                   Navigator.of(context).push(createRouteSumited());
//                 },
//               ),
//               _buildDashboardItem(
//                 context,
//                 color: primaryColor,
//                 icon: Icons.phone,
//                 label: "Appeler un service",
//                 onTap: () {
//                   Navigator.of(context).push(createRouteCall());
//                 },
//               ),
//               _buildDashboardItem(
//                 context,
//                 color: Colors.tealAccent,
//                 icon: Icons.help,
//                 label: "Conseils",
//                 onTap: () {
//                   createRouteAdvice();
//                   Navigator.of(context).push(createRouteAdvice());
//                 },
//               ),
//               _buildDashboardItem(
//                 context,
//                 color: Colors.greenAccent,
//                 icon: Icons.info,
//                 label: "À propos",
//                 onTap: () {
//                   Navigator.of(context).push(createRouteAbout());
//                   createRouteAbout();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardItem(
//     BuildContext context, {
//     required Color color,
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(0, 4),
//               blurRadius: 4,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.white, size: 30.0),
//             const SizedBox(height: 10.0),
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:emergency/routers/routes.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "EMERGENCY",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Action pour les notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildDashboardItem(
                context,
                gradient: const LinearGradient(
                  colors: [Colors.redAccent, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.report_problem,
                label: "Signaler une urgence",
                onTap: () {
                  Navigator.of(context).push(createRouteSumited());
                },
              ),
              _buildDashboardItem(
                context,
                gradient: const LinearGradient(
                  colors: [primaryColor, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.phone,
                label: "Appeler un service",
                onTap: () {
                  Navigator.of(context).push(createRouteCall());
                },
              ),
              _buildDashboardItem(
                context,
                gradient: const LinearGradient(
                  colors: [Colors.tealAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.help,
                label: "Conseils",
                onTap: () {
                  Navigator.of(context).push(createRouteAdvice());
                },
              ),
              _buildDashboardItem(
                context,
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                icon: Icons.info,
                label: "À propos",
                onTap: () {
                  Navigator.of(context).push(createRouteAbout());
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
    required Gradient gradient,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
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
            Icon(icon, color: Colors.white, size: 40.0),
            const SizedBox(height: 10.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
