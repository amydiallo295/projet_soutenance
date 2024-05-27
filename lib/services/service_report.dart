import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../models/model_report.dart';


class EmergencyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final emergencyProvider = FutureProvider<List<DocumentSnapshot>>((ref) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('emergencies').get();
    return querySnapshot.docs;
  });

  Future<List<EmergencySubmission>> getEmergencySubmissions() async {
    QuerySnapshot snapshot = await _firestore.collection('emergencies').get();
    List<EmergencySubmission> submissions = snapshot.docs.map((doc) {
      return EmergencySubmission.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
    return submissions;
  }

  Future<void> submitEmergency(
      EmergencySubmission submission, File? image) async {
    String? imageUrl;

    if (image != null) {
      imageUrl = await _uploadImage(image);
    }

    final newSubmission = EmergencySubmission(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: submission.name,
      phone: submission.phone,
      emergencyType: submission.emergencyType,
      description: submission.description,
      location: submission.location,
      imageUrl: imageUrl,
    );
    await _firestore.collection('emergencies').add(newSubmission.toMap());
  }

  Future<List<DocumentSnapshot>> getEmergencies() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('emergencies').get();
    return querySnapshot.docs;
  }

  Future<String> _uploadImage(File image) async {
    final storageRef =
        _storage.ref().child('emergency_images/${image.path.split('/').last}');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }
}
