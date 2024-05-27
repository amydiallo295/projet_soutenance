import 'package:emergency/main.dart';
import 'package:emergency/ui/sreens/verificationode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendCode() async {
    String phoneNumber = phoneController.text.trim();
    String name = nameController.text.trim();
      // Vérifiez si l'utilisateur est déjà connecté
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if (isLoggedIn) {
    // Si l'utilisateur est déjà connecté, naviguez vers l'écran d'accueil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return;
  }

  // Si l'utilisateur n'est pas déjà connecté, procédez à l'envoi du code de vérification
  await prefs.setString('userName', name);

    // Enregistrez le nom dans SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('userName', name);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Cette méthode est appelée automatiquement si Firebase peut vérifier le numéro de téléphone sans envoyer de code de confirmation.
        // Vous pouvez gérer la connexion automatique ici si nécessaire.
      },
      verificationFailed: (FirebaseAuthException e) {
        // Gérez les erreurs de vérification, par exemple si le numéro de téléphone est invalide.
        print('Erreur de vérification: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Cette méthode est appelée après l'envoi du code de vérification.
        // Passez à l'écran suivant pour saisir le code de vérification
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterCodePage(
                verificationId: verificationId, phoneNumber: phoneNumber),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Cette méthode est appelée lorsque le temps imparti pour récupérer automatiquement le code de vérification expire.
        print('Délai de récupération automatique du code expiré');
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Emergency',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: sendCode,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Envoyer le code',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
