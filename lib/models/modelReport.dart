class EmergencySubmission {
  final String name;
  final String phone;
  final String emergencyType;
  final String description;
  final String location;
  final String? imageUrl;

  EmergencySubmission({
    required this.name,
    required this.phone,
    required this.emergencyType,
    required this.description,
    required this.location,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'emergencyType': emergencyType,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}
