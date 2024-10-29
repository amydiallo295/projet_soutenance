// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:emergency/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emergencyServiceProvider = Provider((ref) => AuthentificationService());

class AuthentificationService extends ChangeNotifier {
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
            const SnackBar(
              content: Text('Erreur lors de la liaison de l\'email'),
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
        errorMessage = 'Code invalide: ';
      } else if (e == 'invalid-verification-id') {
        errorMessage = 'ID invalide: ';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Center(child: Text(message)), backgroundColor: color),
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password,
      String displayName, String phoneNumber, BuildContext context) async {
    if ([email, password, displayName].any((field) => field.isEmpty)) {
      showSnackBar(
          context,
          'Les champs email, mot de passe et nom d\'utilisateur ne peuvent pas être vides.',
          Colors.red);
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(displayName);

        await user.reload();
        // Ajout de l'utilisateur dans Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'createdAt': FieldValue.serverTimestamp(),
          'email': email,
          'name': displayName,
          'role': 'user',
          'uid': user.uid,
          'phoneNumber': phoneNumber,
        });
        notifyListeners();
        // Afficher une notification de_succès
        showSnackBar(
            context, 'Compte créé avec succès! Bienvenue!', Colors.green);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      handleAuthError(e, context);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Initialisez Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        showSnackBar(context, 'Connexion annulée.', Colors.red);
        return;
      }

      // Obtenez les détails d'authentification de la requête
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Créez un nouvel identifiant avec les jetons Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Connectez-vous avec Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Récupération de l'utilisateur authentifié
      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'createdAt': FieldValue.serverTimestamp(),
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
          'role': 'user',
          'uid': user.uid,
          'phoneNumber': userCredential.user!.phoneNumber,
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );

        showSnackBar(context, 'Bienvenue ${user.displayName}!', Colors.green);
      }
    } catch (e) {
      print("Erreur lors de la connexion avec Google⛪⛪⛪⛪⛪⛪⛪: $e");
      showSnackBar(context, 'Erreur de connexion: $e', Colors.red);
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    if ([email, password].any((field) => field.isEmpty)) {
      showSnackBar(context,
          'L\'email et le mot de passe ne peuvent pas être vides.', Colors.red);
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.reload();
        final updatedUser = FirebaseAuth.instance.currentUser;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );

        showSnackBar(
            context, 'Bienvenue ${updatedUser?.displayName}!', Colors.green);
      }
    } catch (e) {
      handleAuthError(e, context);
    }
  }

  void handleAuthError(dynamic error, BuildContext context) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          showSnackBar(context, 'Cet email est déjà utilisé.', Colors.red);
          break;
        case 'weak-password':
          showSnackBar(context, 'Le mot de passe est trop faible.', Colors.red);
          break;
        case 'user-not-found':
          showSnackBar(
              context, 'Aucun utilisateur trouvé pour cet email.', Colors.red);
          break;
        case 'wrong-password':
          showSnackBar(context, 'Mot de passe incorrect.', Colors.red);
          break;
        default:
          showSnackBar(
              context,
              'Informations d\'identification invalides. Veuillez vérifier et réessayer.',
              Colors.red);
      }
    } else {
      showSnackBar(context, 'Une erreur s\'est produite. Veuillez réessayer.',
          Colors.red);
    }
  }
}
