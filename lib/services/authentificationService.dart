// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:emergency/routers/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emergencyServiceProvider = Provider((ref) => AuthentificationService());

class AuthentificationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> signInWithCredential(
  //     String userName,
  //     String phoneNumber,
  //     String verifyCode,
  //     String smsCode,
  //     String userPassword,
  //     BuildContext context) async {
  //   try {
  //     // Créer un PhoneAuthCredential avec le code de vérification et l'ID de vérification
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verifyCode,
  //       smsCode: smsCode,
  //     );

  //     // Authentifier l'utilisateur avec le numéro de téléphone
  //     UserCredential phoneAuthCredential =
  //         await _auth.signInWithCredential(credential);
  //     User? user = phoneAuthCredential.user;

  //     if (user != null) {
  //       // Créer l'email basé sur le numéro de téléphone
  //       String email = '$phoneNumber@example.com';
  //       await user.updateDisplayName(userName);
  //       // Associer l'authentification par email et mot de passe
  //       AuthCredential emailCredential = EmailAuthProvider.credential(
  //         email: email,
  //         password: userPassword,
  //       );

  //       try {
  //         // Lier l'authentification par email et mot de passe au compte existant
  //         await user.linkWithCredential(emailCredential);

  //         // Enregistrer les informations utilisateur dans Firestore
  //         await _firestore.collection('users').doc(user.uid).set({
  //           'phoneNumber': phoneNumber,
  //           'userName': userName,
  //           'email': email,
  //           'lastLoginDate': Timestamp.now(),
  //         });

  //         // Sauvegarder l'état de la connexion
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('isLoggedIn', true);
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Erreur lors de la liaison de l\'email: $e'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //       // Mettre à jour le profil de l'utilisateur avec le nom

  //       await user.reload();
  //       user = _auth.currentUser;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     if (e == 'invalid-verification-code') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Code invalide: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //     if (e == 'invalid-verification-id') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('ID invalide: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Erreur lors de la vérification du code: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> signInWithCredential(
    String userName,
    String phoneNumber,
    String verifyCode,
    String smsCode,
    String userPassword,
    BuildContext context,
  ) async {
    try {
      // Créer un PhoneAuthCredential avec le code de vérification et l'ID de vérification
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyCode,
        smsCode: smsCode,
      );

      // Authentifier l'utilisateur avec les informations de connexion
      UserCredential phoneAuthCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = phoneAuthCredential.user;

      if (user != null) {
        String email = '$phoneNumber@gmail.com';

        await user.updateDisplayName(userName);
        // Associer l'authentification par email et mot de passe
        AuthCredential emailCredential = EmailAuthProvider.credential(
          email: email,
          password: userPassword,
        );

        try {
          // Lier l'authentification par email et mot de passe au compte existant
          await user.linkWithCredential(emailCredential);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'phoneNumber': phoneNumber,
            'userName': userName,
            'email': email,
            'lastLoginDate': Timestamp.now(),
          });

          // Sauvegarder l'état de la connexion
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
        } catch (e) {
          // Afficher une notification en cas d'erreur lors de la liaison de l'email
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur lors de la liaison de l\'email: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }

        // Mettre à jour le profil de l'utilisateur
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        notifyListeners();
      }
    } catch (e) {
      // Afficher une notification en cas d'erreur lors de la vérification du code
      String errorMessage = 'Erreur lors de la vérification du code';
      if (e == 'invalid-verification-code') {
        errorMessage = 'Code invalide: $e';
      } else if (e == 'invalid-verification-id') {
        errorMessage = 'ID invalide: $e';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      // Authentification de l'utilisateur avec l'email et le mot de passe
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$email@gmail.com',
        password: password,
      );

      // Récupération de l'utilisateur authentifié
      final User? user = userCredential.user;

      if (user != null) {
        Navigator.of(context).push(createRouteHomeScreen());
      }
    } catch (e) {
      // Gérer les erreurs potentielles ici
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aucun utilisateur trouvé pour cet email.'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mot de passe incorrect'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Informations d\'identification invalides. Veuillez vérifier et réessayer.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
