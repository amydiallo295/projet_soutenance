// ignore_for_file: use_build_context_synchronously

import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emergency/viewModels/viewModelReport.dart';

class EmergencySubmissionPage extends ConsumerStatefulWidget {
  const EmergencySubmissionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState
    extends ConsumerState<EmergencySubmissionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emergencyViewModel = ref.watch(emergencyViewModelProvider);
    final isLoading = emergencyViewModel.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: TitleWidget(text: "Soumission d'urgence"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 50),
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

                  // MultiSelectDialogField(
                  //   items: emergencyViewModel.emergencyTypes
                  //       .map((e) => MultiSelectItem(e, e))
                  //       .toList(),
                  //   listType: MultiSelectListType.CHIP,
                  //   onConfirm: (values) {
                  //     emergencyViewModel.listOFSelectedItem = values;
                  //     print(
                  //         "selection: ${emergencyViewModel.listOFSelectedItem}");
                  //   },
                  // ),

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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le numéro de téléphone est obligatoire';
                      }
                      if (!value.startsWith('+224')) {
                        return 'Le numéro de téléphone doit commencer par +224';
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
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await emergencyViewModel.submitEmergency();

                                showDialog(
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
                                            emergencyViewModel.phoneController =
                                                TextEditingController(
                                                    text: '+224');

                                            emergencyViewModel
                                                .descriptionController
                                                .clear();
                                            emergencyViewModel.image = null;
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
                        backgroundColor: Colors.blue,
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
