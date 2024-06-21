import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final picker = ImagePicker();

  Position? _currentPosition;
  File? _image;
  bool _isLoading = false;
  List<Map<String, dynamic>> _reportUsers = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+224');
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

  EmergencyViewModel() {
    _getCurrentLocation();
  }

  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;
  File? get image => _image;
  List<Map<String, dynamic>> get reportUsers => _reportUsers;

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setEmergencyType(String? value) {
    selectedEmergencyType = value;
  }

  Future<void> submitEmergency() async {
    _setLoading(true);

    try {
      await _getCurrentLocation();

      final newSubmission = EmergencySubmission(
        name: nameController.text,
        phone: phoneController.text,
        emergencyType: selectedEmergencyType ?? '',
        description: descriptionController.text,
        status: false,
        location: _currentPosition != null
            ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
            : '',
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        createdAt: Timestamp.now(),
      );

      await _service.submitEmergency(newSubmission, _image ?? File(''));
    } catch (e) {
      // Handle the error appropriately here
      print('Error during submission: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Les permissions de localisation sont refusées de façon permanente.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    notifyListeners();
  }

  void resetCurrentPosition() {
    _currentPosition = null;
    notifyListeners();
  }

  void resetCurrentImage() {
    _image = null;
    notifyListeners();
  }

  Future<void> fetchUserReport() async {
    _reportUsers = await _service
        .getUserSubmissions(FirebaseAuth.instance.currentUser?.uid ?? '');
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
