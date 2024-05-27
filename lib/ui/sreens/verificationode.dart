import 'package:emergency/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterCodePage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String userName;

  const EnterCodePage(
      {Key? key,
      required this.verificationId,
      required this.phoneNumber,
      required this.userName})
      : super(key: key);

  @override
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  final TextEditingController codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void verifyCode() async {
    String smsCode = codeController.text.trim();

    // Créer un PhoneAuthCredential avec le code de vérification et l'ID de vérification
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );

    try {
      // Sign in the user with the credential
      await _auth.signInWithCredential(credential).then((value) async => {
            await _firestore.collection('users').doc(widget.phoneNumber).set({
              'phoneNumber': widget.phoneNumber,
              'lastLogin': Timestamp.now(),
              'name': widget.userName,
              // Ajoutez d'autres informations de connexion que vous souhaitez enregistrer
            })
          });

      // Enregistrer les informations dans Firestore
      // Enregistrer l'état de connexion dans SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userPhone', widget.phoneNumber);
      // Ajoutez ici le nom de l'utilisateur si vous le demandez lors de l'inscription
      await prefs.setString('userName', 'Nom d\'utilisateur');

      // Si la vérification réussit, naviguer vers l'écran d'accueil
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userPhone', widget.phoneNumber);
// Ajoutez ici le nom de l'utilisateur si vous le demandez lors de l'inscription
      await prefs.setString('userName', 'Nom d\'utilisateur');
    } catch (e) {
      // Gérer l'échec de la vérification
      print('Erreur lors de la vérification du code: $e');
      // Vous pouvez afficher un message d'erreur à l'utilisateur si la vérification échoue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrer le Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                labelText: 'Code de confirmation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyCode,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
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
                'Vérifier le Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
