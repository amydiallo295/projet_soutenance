import 'dart:io';

import 'package:emergency/services/service_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/model_report.dart';

class EmergencyState {
  final Position? currentPosition;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;

  EmergencyState({
    required this.currentPosition,
    required this.nameController,
    required this.phoneController,
    required this.descriptionController,
    required this.locationController,
  });
}

class EmergencyNotifier extends Notifier<Set<EmergencySubmission>> {
  final EmergencyService _service = EmergencyService();
  Position? _currentPosition;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Set<EmergencySubmission> build() {
    return {};
  }

  File? _image;
  File? get image => _image;

  final _picker = ImagePicker();

  // Ajoutez des getters pour accéder aux variables privées
  Position? get currentPosition => _currentPosition;
  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get locationController => _locationController;

  String? _selectedEmergencyType;
  String? get selectedEmergencyType => _selectedEmergencyType;

  final List<String> _emergencyTypes = [
    'Incendie',
    'Accident de la route',
    'Crime',
    'Urgence médicale',
    'Catastrophe naturelle',
    'Autre'
  ];
  List<String> get emergencyTypes => _emergencyTypes;

  EmergencyViewModel() {
    getCurrentLocation();
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      debugPrint("No image selected");
    }
  }

  void setEmergencyType(String? value) {
    _selectedEmergencyType = value;
  }

  Future<void> submitEmergency() async {
    final newSubmission = EmergencySubmission(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      name: _nameController.text,
      phone: _phoneController.text,
      emergencyType: _selectedEmergencyType ?? '',
      description: _descriptionController.text,
      location: _currentPosition != null
          ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
          : '',
    );

    if (_image != null) {
      await _service.submitEmergency(newSubmission, _image!);
    } else {
      debugPrint("Aucune image sélectionnée pour la soumission.");
    }
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentPosition = position;
  }

  void resetFields() {
    _nameController.clear();
    _phoneController.clear();
    _descriptionController.clear();
    _selectedEmergencyType = null;
    _image = null;
    getCurrentLocation(); // Call getCurrentLocation to reset the location as well
  }
}

final emergencyProvider =
    NotifierProvider<EmergencyNotifier, Set<EmergencySubmission>>(
        () => EmergencyNotifier());
