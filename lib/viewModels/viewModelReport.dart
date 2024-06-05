// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/modelReport.dart';
// import '../services/serviceReport.dart';

// final emergencyViewModelProvider =
//     ChangeNotifierProvider((ref) => EmergencyViewModel());
// final emergencyServiceProvider = Provider((ref) => EmergencyService());

// class EmergencyViewModel extends ChangeNotifier {
//   final EmergencyService _service = EmergencyService();
//   Position? _currentPosition;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();

//   String? selectedEmergencyType;
//   final List<String> emergencyTypes = [
//     'Incendie',
//     'Accident de la route',
//     'Crime',
//     'Urgence médicale',
//     'Catastrophe naturelle',
//     'Autre'
//   ];
//   File? image;

//   final picker = ImagePicker();

//   Position? get currentPosition => _currentPosition;

//   EmergencyViewModel() {
//     getCurrentLocation();
//   }

//   Future<void> getImageFromGallery() async {
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );

//     if (pickedFile != null) {
//       image = File(pickedFile.path);
//       notifyListeners();
//     } else {
//       print("No image selected");
//     }
//   }

//   void setEmergencyType(String? value) {
//     selectedEmergencyType = value;
//     notifyListeners();
//   }

//   Future<void> submitEmergency() async {
//     final newSubmission = EmergencySubmission(
//       name: nameController.text,
//       phone: phoneController.text,
//       emergencyType: selectedEmergencyType ?? '',
//       description: descriptionController.text,
//       status: false,
//       location: _currentPosition != null
//           ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
//           : '',
//     );
//     print("Voir les données du formulaire:");
//     print(newSubmission.toString());

//     if (image != null) {
//       await _service.submitEmergency(newSubmission, image!);
//     } else {
//       print("Aucune image sélectionnée pour la soumission.");
//     }
//     notifyListeners();
//   }

//   Future<void> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Les services de localisation sont désactivés.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Les permissions de localisation sont refusées.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Les permissions de localisation sont refusées de façon permanente, nous ne pouvons pas demander les permissions.');
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     _currentPosition = position;
//     notifyListeners();
//   }

//   void resetFields() {
//     nameController.clear();
//     phoneController.clear();
//     descriptionController.clear();
//     selectedEmergencyType = null;
//     image = null;
//     getCurrentLocation(); // Call getCurrentLocation to reset the location as well
//     notifyListeners();
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../models/modelReport.dart';
import '../services/serviceReport.dart';

final emergencyViewModelProvider =
    ChangeNotifierProvider((ref) => EmergencyViewModel());
final emergencyServiceProvider = Provider((ref) => EmergencyService());

class EmergencyViewModel extends ChangeNotifier {
  final EmergencyService _service = EmergencyService();
  Position? _currentPosition;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedEmergencyType;
  final List<String> emergencyTypes = [
    'Incendie',
    'Accident de la route',
    'Crime',
    'Urgence médicale',
    'Catastrophe naturelle',
    'Autre'
  ];
  File? image;

  final picker = ImagePicker();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;
  List<Map<String, dynamic>> _reportUsers = [];
  List<Map<String, dynamic>> get reportUsers => _reportUsers;

  EmergencyViewModel() {
    getCurrentLocation();
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      print("Aucune image sélectionnée");
    }
  }

  void setEmergencyType(String? value) {
    selectedEmergencyType = value;
    notifyListeners();
  }

  Future<void> submitEmergency() async {
    _isLoading = true;
    notifyListeners();

    final newSubmission = EmergencySubmission(
      name: nameController.text,
      phone: phoneController.text,
      emergencyType: selectedEmergencyType ?? '',
      description: descriptionController.text,
      status: false,
      location: _currentPosition != null
          ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
          : '',
      userId: '${FirebaseAuth.instance.currentUser?.uid}',
    );
    print("Voir les données du formulaire:");
    print(newSubmission.toString());

    if (image != null) {
      await _service.submitEmergency(newSubmission, image!);
    } else {
      print("Aucune image sélectionnée pour la soumission.");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Les permissions de localisation sont refusées de façon permanente, nous ne pouvons pas demander les permissions.');
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      // Handle if user denies location access here
      return Future.error('L\'accès à la localisation est refusé.');
    }

    _currentPosition = position;
    notifyListeners();
  }

  void resetCurrentPosition() {
    _currentPosition = null;
  }

  Future<void> fetUserReport() async {
    _reportUsers = await _service
        .getUserSubmissions('${FirebaseAuth.instance.currentUser?.uid}');
  }
}
