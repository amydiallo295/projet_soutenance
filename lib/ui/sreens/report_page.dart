// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:emergency/utils/app_colors.dart';

class EmergencySubmissionPage extends ConsumerStatefulWidget {
  const EmergencySubmissionPage({super.key});

  @override
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState
    extends ConsumerState<EmergencySubmissionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final emergencyViewModel = ref.read(emergencyViewModelProvider);
      emergencyViewModel.resetCurrentImage();
      emergencyViewModel.nameController.clear();
      emergencyViewModel.phoneController.text =
          '+224'; // Initialize with prefix
      emergencyViewModel.descriptionController.clear();
      emergencyViewModel.setEmergencyType(null);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emergencyViewModel = ref.watch(emergencyViewModelProvider);
    final isLoading = emergencyViewModel.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Soumission d'urgence",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Soumettre une nouvelle urgence',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    iconSize: 30.0,
                    iconEnabledColor: primaryColor,
                    value: emergencyViewModel.selectedEmergencyType,
                    items: emergencyViewModel.emergencyTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      emergencyViewModel.setEmergencyType(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Type d\'urgence',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le type d\'urgence est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emergencyViewModel.nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le nom est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emergencyViewModel.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) {
                      if (!value.startsWith('+224')) {
                        emergencyViewModel.phoneController.text = '+224';
                        emergencyViewModel.phoneController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: emergencyViewModel
                                    .phoneController.text.length));
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le numéro de téléphone est obligatoire';
                      }
                      if (!value.startsWith('+224')) {
                        return 'Le numéro de téléphone doit commencer par +224';
                      }
                      if (value.length <= 8 + 4) {
                        // 8 for the number + 4 for the prefix
                        return 'Le numéro de téléphone doit contenir plus de 8 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emergencyViewModel.descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.image,
                      ),
                      onPressed: emergencyViewModel.getImageFromGallery,
                      label: const Text('Ajouter une image ici'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  emergencyViewModel.image != null
                      ? SizedBox(
                          width: 200,
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                emergencyViewModel.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : const Text(
                          'Aucune image sélectionnée',
                          style: TextStyle(color: Colors.black),
                        ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await emergencyViewModel.submitEmergency();

                                if (!mounted) return;

                                showDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Urgence soumise'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Nom: ${emergencyViewModel.nameController.text}\n'
                                            'Numéro de téléphone: ${emergencyViewModel.phoneController.text}\n'
                                            'Type d\'urgence: ${emergencyViewModel.selectedEmergencyType}\n'
                                            'Description: ${emergencyViewModel.descriptionController.text}\n'
                                            'Localisation: ${emergencyViewModel.currentPosition != null ? '${emergencyViewModel.currentPosition!.latitude}, ${emergencyViewModel.currentPosition!.longitude}' : 'Non disponible'}\n',
                                          ),
                                          if (emergencyViewModel.image != null)
                                            Image.file(
                                              emergencyViewModel.image!,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.scaleDown,
                                            ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            emergencyViewModel.nameController
                                                .clear();
                                            emergencyViewModel.phoneController
                                                .clear();

                                            emergencyViewModel
                                                .descriptionController
                                                .clear();
                                            emergencyViewModel
                                                .resetCurrentImage();
                                            emergencyViewModel
                                                .setEmergencyType(null);
                                            emergencyViewModel
                                                .resetCurrentPosition();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: primaryColor,
                            )
                          : const Text(
                              'Soumettre',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
