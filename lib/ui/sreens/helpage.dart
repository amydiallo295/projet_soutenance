// import 'package:flutter/material.dart';

// class HelpPage extends StatelessWidget {
//   const HelpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppBarColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text("Aide"),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppBarColor, Colors.orangeAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Comment pouvons-nous vous aider?',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppBarColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 _buildHelpSection(
//                   title: 'FAQ',
//                   content:
//                       'Trouvez les réponses aux questions les plus fréquemment posées.',
//                 ),
//                 const SizedBox(height: 20),
//                 _buildHelpSection(
//                   title: 'Tutoriels',
//                   content:
//                       'Découvrez comment utiliser les fonctionnalités de l\'application avec nos guides pas à pas.',
//                 ),
//                 const SizedBox(height: 20),
//                 _buildHelpSection(
//                   title: 'Assistance technique',
//                   content:
//                       'Obtenez des conseils pour résoudre les problèmes techniques courants.',
//                 ),
//                 const SizedBox(height: 20),
//                 _buildHelpSection(
//                   title: 'Support en direct',
//                   content:
//                       'Contactez notre équipe de support en temps réel pour obtenir de l\'aide immédiate.',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHelpSection({required String title, required String content}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: AppBarColor,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           content,
//           style: const TextStyle(fontSize: 16),
//         ),
//         const SizedBox(height: 10),
//         TextButton(onPressed: () {}, child: Text('En savoir plus'))
//       ],
//     );
//   }
// }

import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: TitleWidget(text: "Conseils d'urgence"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Conseils en cas d\'urgence',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildAdviceSection(
                  title: 'Sécurité personnelle',
                  content:
                      '1. Gardez votre calme et essayez d\'évaluer la situation.\n'
                      '2. Éloignez-vous des zones dangereuses si possible.\n'
                      '3. Cherchez un abri sûr si nécessaire.\n'
                      '4. Suivez les instructions des autorités locales.',
                ),
                const SizedBox(height: 20),
                _buildAdviceSection(
                  title: 'Appeler les secours',
                  content:
                      '1. Utilisez l\'application pour signaler l\'urgence ou appelez directement les services d\'urgence.\n'
                      '2. Fournissez des informations claires et précises sur l\'incident.\n'
                      '3. Indiquez votre emplacement exact.\n'
                      '4. Restez en ligne jusqu\'à ce qu\'on vous dise de raccrocher.',
                ),
                const SizedBox(height: 20),
                _buildAdviceSection(
                  title: 'Premiers secours',
                  content:
                      '1. Si quelqu\'un est blessé, essayez de lui administrer les premiers soins si vous êtes formé.\n'
                      '2. Ne déplacez pas les blessés graves à moins qu\'ils soient en danger immédiat.\n'
                      '3. Utilisez une trousse de premiers secours si disponible.',
                ),
                const SizedBox(height: 20),
                _buildAdviceSection(
                  title: 'Utilisation de l\'application',
                  content:
                      '1. Appuyez sur "Signaler une urgence" pour envoyer un signalement immédiat.\n'
                      '2. Fournissez des détails supplémentaires et des photos si possible.\n'
                      '3. Utilisez "Appeler un service" pour contacter directement les secours appropriés.',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Restez en sécurité et suivez toujours les instructions des autorités locales.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdviceSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: appBarColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
