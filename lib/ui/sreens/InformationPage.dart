// import 'package:emergency/utils/app_colors.dart';
// import 'package:emergency/utils/ui_helpers.dart';
// import 'package:flutter/material.dart';

// class InformationPage extends StatelessWidget {
//   const InformationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: primaryColor,
//           title: TitleWidget(
//             text: "Informations d\'Urgence",
//           )),
//       body: const SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 'Informations sur les différents types d\'urgence',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               verticalSpaceSmall,
//               EmergencyType(
//                 image: 'assets/images/ambulance.jpg',
//                 text:
//                     "En cas de problème médical grave, appelez une ambulance et suivez les instructions des opérateurs de secours ou en cas d'accident Assurez-vous que la zone est sécurisée, appelez les secours et fournissez les premiers soins si vous êtes formé ",
//               ),
//               EmergencyType(
//                 image: 'assets/images/police.jpg',
//                 text:
//                     'Si vous êtes témoin d\'un crime, appelez la police immédiatement et fournissez autant de détails que possible sans vous mettre en danger',
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Conseils de sécurité et de prévention',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               SafetyTips(
//                 text:
//                     'Prévention des incendies : Installez des détecteurs de fumée, gardez des extincteurs à portée de main et ne laissez jamais les appareils de cuisson sans surveillance.',
//               ),
//               SafetyTips(
//                 text:
//                     'Sécurité routière : Portez toujours votre ceinture de sécurité, respectez les limites de vitesse et ne conduisez jamais sous l\'influence de l\'alcool ou de drogues.',
//               ),
//               SafetyTips(
//                 text:
//                     'Santé : Ayez une trousse de premiers soins à la maison, connaissez les gestes de premiers secours de base et consultez régulièrement un médecin.',
//               ),
//               SafetyTips(
//                 text:
//                     'Sécurité personnelle : Soyez conscient de votre environnement, évitez les zones dangereuses la nuit et ne partagez pas d\'informations personnelles avec des inconnus.',
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Liste des numéros d\'urgence locaux',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               EmergencyNumbers(
//                 number: 'Police : 17',
//               ),
//               EmergencyNumbers(
//                 number: 'Pompiers : 18',
//               ),
//               EmergencyNumbers(
//                 number: 'SAMU (Services d\'Aide Médicale Urgente) : 15',
//               ),
//               EmergencyNumbers(
//                 number: 'Numéro d\'urgence européen : 112',
//               ),
//               EmergencyNumbers(
//                 number: 'Centre antipoison : 01 40 05 48 48',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EmergencyType extends StatelessWidget {
//   final String image;
//   final String text;

//   const EmergencyType({Key? key, required this.image, required this.text})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: 500,
//           height: 300,

//           child: Image.asset(
//             image,
//             fit: BoxFit.cover,
//           ), // Replace with your image widget,
//         ),
//         SizedBox(height: 10),
//         Text(text),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   /** Column(
//       children: [
//         Image.asset(
//           image,
//           width: 100,
//           height: 100,
//         ), // Replace with your image widget
//         SizedBox(height: 10),
//         Text(text),
//         SizedBox(height: 20),
//       ],
//     ); */
// }

// class SafetyTips extends StatelessWidget {
//   final String text;

//   const SafetyTips({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(text);
//   }
// }

// class EmergencyNumbers extends StatelessWidget {
//   final String number;

//   const EmergencyNumbers({Key? key, required this.number}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(number);
//   }
// }

import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(
          text: "Informations",
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'À propos de l\'application',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cette application permet aux utilisateurs de signaler des urgences de manière rapide et efficace. Vous pouvez signaler différents types d\'urgences, appeler des services d\'urgence et obtenir de l\'aide rapidement.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  title: 'Comment utiliser l\'application',
                  content:
                      '1. Pour signaler une urgence, appuyez sur le bouton "Signaler une urgence" sur la page d\'accueil.\n'
                      '2. Pour appeler un service d\'urgence, sélectionnez le service approprié dans la section "Appeler un service".\n'
                      '3. Vous pouvez également consulter l\'historique de vos signalements dans la section "Historique".',
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  title: 'Fonctionnalités principales',
                  content: '- Signalement rapide des urgences\n'
                      '- Appels directs aux services d\'urgence\n'
                      '- Localisation automatique de l\'incident\n'
                      '- Envoi de photos et de vidéos pour plus de précision\n'
                      '- Historique des signalements',
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  title: 'Contactez-nous',
                  content:
                      'Pour toute question ou assistance, veuillez nous contacter à :\n'
                      'Email: support@emergencyapp.com\n'
                      'Téléphone: +123 456 7890',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Merci d\'utiliser notre application!',
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

  Widget _buildInfoSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
