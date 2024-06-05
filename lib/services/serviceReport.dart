// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:io';

// import '../models/modelReport.dart';

// class EmergencyService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final emergencyProvider = FutureProvider<List<DocumentSnapshot>>((ref) async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('emergencies').get();
//     return querySnapshot.docs;
//   });

//   Future<void> submitEmergency(
//       EmergencySubmission submission, File? image) async {
//     String? imageUrl;

//     if (image != null) {
//       imageUrl = await _uploadImage(image);
//     }

//     final newSubmission = EmergencySubmission(
//       name: submission.name,
//       phone: submission.phone,
//       status: submission.status,
//       emergencyType: submission.emergencyType,
//       description: submission.description,
//       location: submission.location,
//       imageUrl: imageUrl,
//       userId: submission.userId,
//     );
//     await _firestore.collection('emergencies').add(newSubmission.toMap());
//   }

//   Future<String> _uploadImage(File image) async {
//     final storageRef =
//         _storage.ref().child('emergency_images/${image.path.split('/').last}');
//     await storageRef.putFile(image);
//     return await storageRef.getDownloadURL();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../models/modelReport.dart';

class EmergencyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final emergencyProvider = FutureProvider<List<DocumentSnapshot>>((ref) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('emergencies').get();
    return querySnapshot.docs;
  });

  Future<void> submitEmergency(
      EmergencySubmission submission, File? image) async {
    String? imageUrl;

    if (image != null) {
      imageUrl = await _uploadImage(image);
    }

    final newSubmission = EmergencySubmission(
      name: submission.name,
      phone: submission.phone,
      status: submission.status,
      emergencyType: submission.emergencyType,
      description: submission.description,
      location: submission.location,
      imageUrl: imageUrl,
      userId: submission.userId,
      cretedAt: submission.cretedAt,
    );
    await _firestore.collection('emergencies').add(newSubmission.toMap());
  }

  Future<String> _uploadImage(File image) async {
    final storageRef =
        _storage.ref().child('emergency_images/${image.path.split('/').last}');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }

  // Nouvelle méthode pour récupérer les signalements d'un utilisateur
  // Nouvelle méthode pour récupérer les signalements d'un utilisateur
  Future<List<Map<String, dynamic>>> getUserSubmissions(String userId) async {
    final querySnapshot = await _firestore
        .collection('emergencies')
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
