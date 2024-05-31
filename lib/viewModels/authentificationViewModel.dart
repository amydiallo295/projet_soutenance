import 'package:emergency/main.dart';
import 'package:emergency/services/authentificationService.dart';
import 'package:emergency/ui/sreens/verificationode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

final authServiceProvider = Provider((ref) => AuthentificationService());

final authViewModelProvider =
    ChangeNotifierProvider((ref) => AuthViewModel(ref));

class AuthViewModel extends ChangeNotifier {
  final Ref _read;

  AuthViewModel(this._read);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityResult get connectivityResult => _connectivityResult;
  Future userCodeVerifyToLogin(String verifyCode, String userName,
      String smsCode, String phoneNumber, BuildContext context) async {
    try {
      await _read
          .read(authServiceProvider)
          .signInWithCredential(
            userName,
            phoneNumber,
            verifyCode,
            smsCode,
            context,
          )
          .then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } catch (e) {
      // Gérer l'échec de la vérification
      print('Erreur lors de la vérification du code: $e');
    }
  }

  // Future sendToPhoneCode(
  //     BuildContext context, String phoneNumber, String userName) async {
  //   print("🫅🫅222222");
  //   print(phoneNumber);
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Cette méthode est appelée automatiquement si Firebase peut vérifier le numéro de téléphone sans envoyer de code de confirmation.
  //       // Vous pouvez gérer la connexion automatique ici si nécessaire.
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       // Gérez les erreurs de vérification, par exemple si le numéro de téléphone est invalide.
  //       print('Erreur de vérification: ${e.message}');
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       // Cette méthode est appelée après l'envoi du code de vérification.
  //       // Passez à l'écran suivant pour saisir le code de vérification

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => EnterCodePage(
  //               verificationId: verificationId,
  //               phoneNumber: phoneNumber,
  //               userName: userName),
  //         ),
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // Cette méthode est appelée lorsque le temps imparti pour récupérer automatiquement le code de vérification expire.
  //       print('Délai de récupération automatique du code expiré');
  //     },
  //     timeout: const Duration(seconds: 60),
  //   );
  // }

  Future<void> sendToPhoneCode(
      BuildContext context, String phoneNumber, String userName) async {
    try {
      print("🫅🫅222222");
      print(phoneNumber);
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Cette méthode est appelée automatiquement si Firebase peut vérifier le numéro de téléphone sans envoyer de code de confirmation.
          // Vous pouvez gérer la connexion automatique ici si nécessaire.
        },
        verificationFailed: (FirebaseAuthException e) {
          // Gérez les erreurs de vérification, par exemple si le numéro de téléphone est invalide.
          print('Erreur de vérification: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur de vérification: ${e.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Cette méthode est appelée après l'envoi du code de vérification.
          // Passez à l'écran suivant pour saisir le code de vérification
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterCodePage(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                  userName: userName),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Cette méthode est appelée lorsque le temps imparti pour récupérer automatiquement le code de vérification expire.
          print('Délai de récupération automatique du code expiré');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Délai de récupération automatique du code expiré'),
              backgroundColor: Colors.red,
            ),
          );
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      print('Erreur lors de la vérification du numéro de téléphone: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Erreur lors de la vérification du numéro de téléphone: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Code qui sera toujours exécuté (que l'opération réussisse ou échoue)
      // Par exemple, arrêter un indicateur de chargement
    }
  }

  Future<ConnectivityResult> checkNetworkConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
    return _connectivityResult;
  }
}
