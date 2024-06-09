import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModelProvider =
    ChangeNotifierProvider((ref) => ProfileViewModel());

class ProfileViewModel extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileViewModel() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> updateUserProfile({
    String? displayName,
    String? phoneNumber,
  }) async {
    if (_currentUser != null) {
      String userData = displayName ?? _currentUser!.displayName ?? "";

      // Mettre à jour Firebase Authentication
      try {
        await _currentUser!.updateDisplayName(userData);
      } catch (e) {
        const SnackBar(
          content: Text("Erreur lors de la mise à jour du nom d'utilisateur"),
          backgroundColor: Colors.red,
        );

        // Gérer les erreurs de mise à jour
      }

      // Mettre à jour Firestore
      try {
        await _firestore.collection('users').doc(_currentUser!.uid).update({
          'userName': userData,
          'phoneNumber': phoneNumber ?? _currentUser!.phoneNumber,
        });
      } catch (e) {
        const SnackBar(
          content: Text("Erreur lors de la mise à jour du document Firestore"),
          backgroundColor: Colors.red,
        );
        // Gérer les erreurs de mise à jour
      }

      // Recharger l'utilisateur pour obtenir les informations mises à jour
      try {
        await _currentUser!.reload();
        _currentUser = FirebaseAuth.instance.currentUser;
        notifyListeners();
      } catch (e) {
        const SnackBar(
          content: Text("Erreur lors du rechargement de l'utilisateur"),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, Function(String) codeSentCallback) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _currentUser!.updatePhoneNumber(credential);
        // Vous pouvez également mettre à jour Firestore ici si nécessaire
      },
      verificationFailed: (FirebaseAuthException e) {
        const SnackBar(
          content: Text('Erreur lors de la vérification '),
          backgroundColor: Colors.red,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> updatePhoneNumberWithCode(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      await _currentUser!.updatePhoneNumber(credential);
      // Mettre à jour Firestore si nécessaire
      await _firestore.collection('users').doc(_currentUser!.uid).update({
        'phoneNumber': _currentUser!.phoneNumber,
      });

      // Recharger l'utilisateur pour obtenir les informations mises à jour
      await _currentUser!.reload();
      _currentUser = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } catch (e) {
      const SnackBar(
        content: Text('Erreur lors de la mise à jour du numéro de téléphone'),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> updateUserPassword(String userpassword) async {
    try {
      await _currentUser!.updatePassword(userpassword);
      // Recharger l'utilisateur pour obtenir les informations mises à jour
      await _currentUser!.reload();
      _currentUser = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } catch (e) {
      const SnackBar(
        content: Text('Erreur lors de la mise à jour du numéro de téléphone'),
        backgroundColor: Colors.red,
      );
    }
  }
}
