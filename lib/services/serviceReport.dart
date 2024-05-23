import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../models/modelReport.dart';

class EmergencyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> submitEmergency(
      EmergencySubmission submission, File? image) async {
    //String? imageUrl;

    // if (image != null) {
    //   imageUrl = await _uploadImage(image);
    // }

    final newSubmission = EmergencySubmission(
      name: submission.name,
      phone: submission.phone,
      emergencyType: submission.emergencyType,
      description: submission.description,
      location: submission.location,
     // imageUrl: imageUrl,
    );
    await _firestore.collection('emergencies').add(newSubmission.toMap());
  }

  // Future<String> _uploadImage(File image) async {
  //   final storageRef = _storage.ref().child('emergency_images/${image.path.split('/').last}');
  //   await storageRef.putFile(image);
  //   return await storageRef.getDownloadURL();
  // }
}
