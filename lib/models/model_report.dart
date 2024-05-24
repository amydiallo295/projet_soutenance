// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmergencySubmission {
  final String id;
  final String name;
  final String phone;
  final String emergencyType;
  final String description;
  final String location;
  final String? imageUrl;

  EmergencySubmission({
    required this.id,
    required this.name,
    required this.phone,
    required this.emergencyType,
    required this.description,
    required this.location,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'emergencyType': emergencyType,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  factory EmergencySubmission.fromMap(Map<String, dynamic> map) {
    return EmergencySubmission(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      emergencyType: map['emergencyType'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencySubmission.fromJson(String source) =>
      EmergencySubmission.fromMap(json.decode(source) as Map<String, dynamic>);
}
