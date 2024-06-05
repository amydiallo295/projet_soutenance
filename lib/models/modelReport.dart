import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencySubmission {
  final String name;
  final String phone;
  final String emergencyType;
  final String description;
  final bool status;
  final String location;
  final String? imageUrl;
  bool isTreat;
  final String userId;
  final Timestamp cretedAt;

  // 'lastLoginDate': Timestamp.now(),
  // Tim // Ajoutez ce champ

  EmergencySubmission({
    required this.name,
    required this.phone,
    required this.emergencyType,
    required this.status,
    required this.description,
    required this.location,
    this.imageUrl,
    this.isTreat = false,
    required this.userId,
    required this.cretedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'emergencyType': emergencyType,
      'description': description,
      'location': location,
      'status': status,
      'imageUrl': imageUrl,
      'isTreat': isTreat,
      'userId': userId,
      'cretedAt': Timestamp.now(),
    };
  }
}
