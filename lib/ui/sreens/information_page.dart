
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(
          text: "Informations",
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor],
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
                    color: appBarColor,
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
            color: appBarColor,
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
