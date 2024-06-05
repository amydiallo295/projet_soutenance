class EmergencySubmission {
  final String name;
  final String phone;
  final String emergencyType;
  final String description;
  final bool status;
  final String location;
  final String? imageUrl;
  bool isTreat;

  EmergencySubmission({
    required this.name,
    required this.phone,
    required this.emergencyType,
    required this.status,
    required this.description,
    required this.location,
    this.imageUrl,
    this.isTreat = false,
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
      'isTreat': isTreat
    };
  }
}
