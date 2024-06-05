import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        centerTitle: true,
        title: TitleWidget(text: 'Politique de confidentialité '),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Politique de confidentialité',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                "Politique de confidentialité  "
                "Cette Politique de confidentialité décrit comment les informations personnelles sont collectées,"
                "utilisées et partagées lorsque vous utilisez l'application de gestion d'urgence (ci-après dénommée l'Application)"
                "Collecte et Utilisation des Informations"
                "Nous recueillons des informations personnelles que vous nous fournissez directement lors de l'utilisation de l'Application. "
                "Les types d'informations personnelles que nous pouvons collecter incluent votre nom,  "
                "votre numéro de téléphone, votre adresse e-mail et toute autre information que vous choisissez de nous fournir."
                "Nous pouvons également collecter automatiquement des informations sur votre appareil, "
                " y compris, mais sans s'y limiter, votre adresse IP, votre type de navigateur,"
                " votre fuseau horaire et certaines des cookies qui sont installés sur votre appareil. "
                "  De plus, lorsque vous naviguez sur l'Application, nous recueillons des informations sur les pages web ou les fonctionnalités de l'Application"
                "que vous consultez, les mots-clés que vous avez saisis, le temps passé sur chaque page, et d'autres statistiques sur votre interaction avec "
                "l'Application. "
                "Nous utilisons les informations collectées pour fournir et améliorer l'Application, pour communiquer avec vous, pour vous offrir des mises "
                "à jour, des alertes et d'autres informations relatives à l'urgence, ainsi que pour des fins publicitaires ou de marketing."
                "Partage des Informations"
                "Nous ne partageons vos informations personnelles avec des tiers que dans les cas suivants : "
                "Avec votre consentement ; "
                "Lorsque cela est nécessaire pour répondre à une situation d'urgence ou pour protéger la sécurité de toute personne ;"
                "Pour se conformer à une obligation légale ou réglementaire ;"
                "Pour protéger nos droits ou notre propriété ;"
                "Avec des fournisseurs de services tiers, des sous-traitants et d'autres tiers qui nous aident à exploiter l'Application ou à mener nos activités, sous réserve qu'ils acceptent également de protéger la confidentialité des informations."
                "Sécurité"
                "La sécurité de vos informations personnelles est importante pour nous, mais rappelez-vous qu'aucune méthode de transmission sur Internet ou méthode de stockage électronique n'est sûre à 100%. Bien que nous nous efforcions d'utiliser des moyens commercialement acceptables pour protéger vos informations personnelles, nous ne pouvons garantir leur sécurité absolue."
                "Modifications de cette Politique de Confidentialité"
                "Nous nous réservons le droit de mettre à jour ou de modifier notre Politique de confidentialité à tout moment et vous devriez consulter cette Politique de confidentialité périodiquement. Votre utilisation continue de l'Application après toute modification de cette Politique de confidentialité constitue votre acceptation de ces modifications.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
