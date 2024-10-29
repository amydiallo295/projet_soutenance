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

  // Future<void> _loadCurrentUser() async {
  //   _currentUser = FirebaseAuth.instance.currentUser;
  //   notifyListeners();
  // }

  Map<String, dynamic>? _firestoreUserData;

  Map<String, dynamic>? get firestoreUserData => _firestoreUserData;

  // Fonction pour charger l'utilisateur actuel depuis Firebase Auth
  Future<void> _loadCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      await _loadUserFromFirestore(_currentUser!.uid);
    }
    notifyListeners();
  }

  // Fonction pour récupérer les informations de l'utilisateur dans Firestore
  Future<void> _loadUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        _firestoreUserData = userDoc.data();
        notifyListeners();
      } else {
        print("L'utilisateur n'existe pas dans Firestore.");
      }
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur: $e");
    }
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
    if (_currentUser == null) return;

    String newDisplayName = displayName ?? _currentUser!.displayName ?? "";
    String? currentPhoneNumber = _currentUser!.phoneNumber;
    bool isPhoneNumberChange =
        phoneNumber != null && phoneNumber != currentPhoneNumber;

    try {
      // Mettre à jour Firebase Authentication
      await _updateFirebaseAuthProfile(newDisplayName,
          isPhoneNumberChange ? phoneNumber : currentPhoneNumber!);

      // Mettre à jour Firestore
      await _updateFirestoreProfile(
          newDisplayName, phoneNumber ?? currentPhoneNumber!);

      // Recharger l'utilisateur pour obtenir les informations mises à jour
      await _currentUser!.reload();
      _currentUser = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } catch (e) {
      _showSnackBar("Erreur lors de la mise à jour du profil", Colors.red);
    }
  }

  Future<void> _updateFirebaseAuthProfile(
      String displayName, String phoneNumber) async {
    try {
      await _currentUser!.updateDisplayName(displayName);
      await _currentUser!.verifyBeforeUpdateEmail('$phoneNumber@gmail.com');
      await _currentUser!.reload();
    } catch (e) {
      _showSnackBar(
          "Erreur lors de la mise à jour du nom d'utilisateur", Colors.red);
      rethrow;
    }
  }

  Future<void> _updateFirestoreProfile(
      String displayName, String phoneNumber) async {
    try {
      await _firestore.collection('users').doc(_currentUser!.uid).update({
        'userName': displayName,
        'phoneNumber': phoneNumber,
        'email': '$phoneNumber@gmail.com',
      });
    } catch (e) {
      _showSnackBar(
          "Erreur lors de la mise à jour du document Firestore", Colors.red);
      rethrow;
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
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
