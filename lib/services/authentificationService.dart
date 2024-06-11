// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:emergency/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

//   Future<void> signInWithEmailAndPassword(
//       String email, String password, BuildContext context) async {
//     try {
//       // Authentification de l'utilisateur avec l'email et le mot de passe
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: '$email@gmail.com',
//         password: password,
//       );

//       // Récupération de l'utilisateur authentifié
//       final User? user = userCredential.user;

//       if (user != null) {
//         // Mettre à jour le profil de l'utilisateur
//         await user.updateDisplayName(user.displayName);

//         await user.reload();
//         final updatedUser = FirebaseAuth.instance.currentUser;
//         notifyListeners();

//         // Naviguer vers la page d'accueil
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomeScreen(),
//           ),
//           (route) => false, // Supprime toutes les autres routes
//         );

//         // Afficher un message de succès
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Bienvenue ${updatedUser?.displayName}!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } catch (e) {
//       // Gérer les erreurs potentielles ici
//       if (e is FirebaseAuthException) {
//         if (e.code == 'user-not-found') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Aucun utilisateur trouvé pour cet email.'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         } else if (e.code == 'wrong-password') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Mot de passe incorrect'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                   'Informations d\'identification invalides. Veuillez vérifier et réessayer.'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     }
//   }
// }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('L\'email et le mot de passe ne peuvent pas être vides.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
        // Mettre à jour le profil de l'utilisateur si nécessaire
        if (user.displayName != null && user.displayName!.isNotEmpty) {
          print("infos user⛪⛪⛪⛪⛪⛪⛪");
          await user.updateDisplayName(user.displayName);
        }

        await user.reload();
        final updatedUser = FirebaseAuth.instance.currentUser;
        notifyListeners();
        // Naviguer vers la page d'accueil
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false, // Supprime toutes les autres routes
        );

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bienvenue ${updatedUser?.displayName}!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
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
              content: Text('Mot de passe incorrect.'),
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
      } else {
        // Gestion des erreurs non FirebaseAuthException
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Une erreur s\'est produite. Veuillez réessayer.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
