import 'package:emergency/main.dart';
import 'package:emergency/services/authentificationService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:emergency/ui/screens/home_page/accueil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

final emergencyServiceProvider = Provider((ref) => AuthentificationService());

class AuthViewModel extends ChangeNotifier {
 

  void userAuthVerify(String verifyCode, String userName, String smsCode,
      String phoneNumber, BuildContext context) async {
    

    try {
        
      // Si la vérification réussit, naviguer vers l'écran d'accueil
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // Gérer l'échec de la vérification
      print('Erreur lors de la vérification du code: $e');
      // Vous pouvez afficher un message d'erreur à l'utilisateur si la vérification échoue
    }
  }
}
