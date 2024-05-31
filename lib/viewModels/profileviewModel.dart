// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emergency/viewModels/viewModelReport.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final profileViewModelProvider =
//     ChangeNotifierProvider((ref) => ProfileViewModel());

// class ProfileViewModel extends ChangeNotifier {
//   User? _currentUser;

//   User? get currentUser => _currentUser;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   ProfileViewModel() {
//     _loadCurrentUser();
//   }

//   Future<void> _loadCurrentUser() async {
//     _currentUser = FirebaseAuth.instance.currentUser;
//     notifyListeners();
//   }

//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//     _currentUser = null;
//     notifyListeners();
//   }

//   Future<void> updateUserProfile({displayName, phoneNumber}) async {
//     print("afficher les infos user");
//     print(displayName);
//     print(phoneNumber);
//     if (_currentUser != null) {
//       //  final user = FirebaseAuth.instance.currentUser;
//       String userData = displayName ?? _currentUser?.displayName;
//       PhoneAuthCredential phoneNumberData =
//           phoneNumber ?? _currentUser?.phoneNumber;

//       // currentUser?.updateDisplayName(userData);
//       // currentUser?.updatePhoneNumber(phoneNumberData);

//       // Update Firestore document
//       // await _firestore.collection('users').doc(currentUser?.uid).update({
//       //   'userName': displayName ?? currentUser?.displayName,
//       //   'phoneNumber': phoneNumber ?? currentUser?.phoneNumber,
//       // });

//       // Reload user to get updated information
//       // await currentUser?.reload();
//       // _currentUser = currentUser;
//       // notifyListeners();
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emergency/viewModels/viewModelReport.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final profileViewModelProvider =
//     ChangeNotifierProvider((ref) => ProfileViewModel());

// class ProfileViewModel extends ChangeNotifier {
//   User? _currentUser;
//   User? get currentUser => _currentUser;

//   String? _verificationId;
//   String? get verificationId => _verificationId ?? "";
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   ProfileViewModel() {
//     _loadCurrentUser();
//   }

//   Future<void> _loadCurrentUser() async {
//     _currentUser = FirebaseAuth.instance.currentUser;
//     notifyListeners();
//   }

//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//     _currentUser = null;
//     notifyListeners();
//   }

//   Future<void> updateUserProfile(
//       {String? displayName, String? phoneNumber}) async {
//     if (_currentUser != null) {
//       String userData = displayName ?? _currentUser!.displayName ?? "";
//       dynamic phoneNumberData = phoneNumber ?? _currentUser!.phoneNumber ?? "";

//       // Mettre à jour Firebase Authentication
//       try {
//         await _currentUser!.updateDisplayName(userData);
//         await _currentUser!.updatePhoneNumber(phoneNumberData);
//       } catch (e) {
//         print("Erreur lors de la mise à jour de l'utilisateur : $e");
//         // Gérer les erreurs de mise à jour
//       }

//       // Mettre à jour Firestore
//       try {
//         await _firestore.collection('users').doc(_currentUser!.uid).update({
//           'userName': userData,
//           'phoneNumber': phoneNumberData,
//         });
//       } catch (e) {
//         print("Erreur lors de la mise à jour du document Firestore : $e");
//         // Gérer les erreurs de mise à jour
//       }

//       // Recharger l'utilisateur pour obtenir les informations mises à jour
//       try {
//         await _currentUser!.reload();
//         _currentUser = FirebaseAuth.instance.currentUser;
//         notifyListeners();
//       } catch (e) {
//         print("Erreur lors du rechargement de l'utilisateur : $e");
//         // Gérer les erreurs de rechargement
//       }
//     }
//   }

//   Future<void> sendVerificationCode(String phoneNumber) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto-retrieval or instant verification
//         await _currentUser?.updatePhoneNumber(credential);
//         await _updateFirestorePhoneNumber(phoneNumber);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print("Erreur lors de la vérification : $e");
//         // Gérer l'erreur de vérification
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Stocker verificationId et resendToken pour une utilisation ultérieure
//         _verificationId = verificationId;
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//       },
//     );
//   }

//   Future<void> _updateFirestorePhoneNumber(String phoneNumber) async {
//     if (_currentUser != null) {
//       await _firestore
//           .collection('users')
//           .doc(_currentUser!.uid)
//           .update({'phoneNumber': phoneNumber,

//            'lastLoginDate': Timestamp.now()});
//     }
//           }
//     }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
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
    print("object,djd;;dkd;kd");
    print(currentUser);
    _currentUser = null;
    notifyListeners();
  }

  Future<void> updateUserProfile(
      {String? displayName, String? phoneNumber}) async {
    if (_currentUser != null) {
      String userData = displayName ?? _currentUser!.displayName ?? "";

      // Mettre à jour Firebase Authentication
      try {
        await _currentUser!.updateDisplayName(userData);
      } catch (e) {
        print("Erreur lors de la mise à jour du nom d'utilisateur : $e");
        // Gérer les erreurs de mise à jour
      }

      // Mettre à jour Firestore
      try {
        await _firestore.collection('users').doc(_currentUser!.uid).update({
          'userName': userData,
          'phoneNumber': phoneNumber ??
              _currentUser!
                  .phoneNumber, // Update phone number only in Firestore
        });
      } catch (e) {
        print("Erreur lors de la mise à jour du document Firestore : $e");
        // Gérer les erreurs de mise à jour
      }

      // Recharger l'utilisateur pour obtenir les informations mises à jour
      try {
        await _currentUser!.reload();
        _currentUser = FirebaseAuth.instance.currentUser;
        notifyListeners();
      } catch (e) {
        print("Erreur lors du rechargement de l'utilisateur : $e");
        // Gérer les erreurs de rechargement
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
        print("Échec de la vérification : $e");
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
      print("Erreur lors de la mise à jour du numéro de téléphone : $e");
    }
  }
}
