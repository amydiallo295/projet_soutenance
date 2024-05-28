import 'dart:async';

import 'package:emergency/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithCredential(
      AuthCredential credential, String userName, String phoneNumber) async {
    // ignore: unused_element
    Future verifyCode(String verifyCode, String userName, String smsCode,
        String phoneNumber, BuildContext context) async {
      // Créer un PhoneAuthCredential avec le code de vérification et l'ID de vérification
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyCode,
        smsCode: smsCode,
      );

      // Enregistrer les informations dans Firestore
      await _auth.signInWithCredential(credential).then((value) async {
        User? user = _auth.currentUser;
        if (user != null) {
          // Mettre à jour le profil de l'utilisateur avec le nom
          await user.updateDisplayName(userName);
          await user.reload();
          user = _auth.currentUser;

          // Enregistrer les informations utilisateur dans Firestore
          await _firestore.collection('users').doc(user!.uid).set({
            'phoneNumber': phoneNumber,
            'userName': userName,
            'lastLoginDate': Timestamp.now(),
          });
        }
      });

      // Sauvegarder l'état de la connexion
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    }
  }
}
