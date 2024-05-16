import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations d\'Urgence'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Informations sur les différents types d\'urgence',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              EmergencyType(
                image: 'assets/images/ambulance.jpg',
                text:
                    "En cas de problème médical grave, appelez une ambulance et suivez les instructions des opérateurs de secours ou en cas d'accident Assurez-vous que la zone est sécurisée, appelez les secours et fournissez les premiers soins si vous êtes formé ",
              ),
              EmergencyType(
                image: 'assets/images/police.jpg',
                text:
                    'Si vous êtes témoin d\'un crime, appelez la police immédiatement et fournissez autant de détails que possible sans vous mettre en danger',
              ),
              SizedBox(height: 20),
              Text(
                'Conseils de sécurité et de prévention',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SafetyTips(
                text:
                    'Prévention des incendies : Installez des détecteurs de fumée, gardez des extincteurs à portée de main et ne laissez jamais les appareils de cuisson sans surveillance.',
              ),
              SafetyTips(
                text:
                    'Sécurité routière : Portez toujours votre ceinture de sécurité, respectez les limites de vitesse et ne conduisez jamais sous l\'influence de l\'alcool ou de drogues.',
              ),
              SafetyTips(
                text:
                    'Santé : Ayez une trousse de premiers soins à la maison, connaissez les gestes de premiers secours de base et consultez régulièrement un médecin.',
              ),
              SafetyTips(
                text:
                    'Sécurité personnelle : Soyez conscient de votre environnement, évitez les zones dangereuses la nuit et ne partagez pas d\'informations personnelles avec des inconnus.',
              ),
              SizedBox(height: 20),
              Text(
                'Liste des numéros d\'urgence locaux',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              EmergencyNumbers(
                number: 'Police : 17',
              ),
              EmergencyNumbers(
                number: 'Pompiers : 18',
              ),
              EmergencyNumbers(
                number: 'SAMU (Services d\'Aide Médicale Urgente) : 15',
              ),
              EmergencyNumbers(
                number: 'Numéro d\'urgence européen : 112',
              ),
              EmergencyNumbers(
                number: 'Centre antipoison : 01 40 05 48 48',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyType extends StatelessWidget {
  final String image;
  final String text;

  const EmergencyType({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 400,
          height: 100,

          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ), // Replace with your image widget,
        ),
        SizedBox(height: 10),
        Text(text),
        SizedBox(height: 20),
      ],
    );
  }

  /** Column(
      children: [
        Image.asset(
          image,
          width: 100,
          height: 100,
        ), // Replace with your image widget
        SizedBox(height: 10),
        Text(text),
        SizedBox(height: 20),
      ],
    ); */
}

class SafetyTips extends StatelessWidget {
  final String text;

  const SafetyTips({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class EmergencyNumbers extends StatelessWidget {
  final String number;

  const EmergencyNumbers({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(number);
  }
}
