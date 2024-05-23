import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/utils/app_colors.dart';
import '/utils/ui_helpers.dart';

class EmergencySubmissionPage extends ConsumerStatefulWidget {
  const EmergencySubmissionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState
    extends ConsumerState<EmergencySubmissionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(emergencyViewModelProvider).getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = ref.watch(emergencyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Soumission d'urgence"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Soumettre une nouvelle urgence',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reportProvider.nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reportProvider.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: reportProvider.selectedEmergencyType,
                  items: reportProvider.emergencyTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    reportProvider.setEmergencyType(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Type d\'urgence',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reportProvider.descriptionController,
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
                  child: ElevatedButton(
                    onPressed: reportProvider.getImageFromGallery,
                    child: const Text('Ajouter une image'),
                  ),
                ),
                const SizedBox(height: 20),
                reportProvider.image != null
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
                              reportProvider.image!,
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : const Text(
                        'Aucune image sélectionnée',
                        style: TextStyle(color: Colors.red),
                      ),
                const SizedBox(height: 20),
                Text(
                  reportProvider.currentPosition != null
                      ? 'Localisation: ${reportProvider.currentPosition!.latitude}, ${reportProvider.currentPosition!.longitude}'
                      : 'Localisation non disponible',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appBarColor,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await reportProvider.submitEmergency();

                      String name = reportProvider.nameController.text;
                      String phone = reportProvider.phoneController.text;
                      String emergencyType =
                          reportProvider.selectedEmergencyType ??
                              'Non spécifié';
                      String description =
                          reportProvider.descriptionController.text;
                      String location = reportProvider.currentPosition != null
                          ? '${reportProvider.currentPosition!.latitude}, ${reportProvider.currentPosition!.longitude}'
                          : 'Non spécifié';

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Urgence soumise'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Nom: $name\n'
                                    'Numéro de téléphone: $phone\n'
                                    'Type d\'urgence: $emergencyType\n'
                                    'Description: $description\n'
                                    'Localisation: $location\n'),
                                if (reportProvider.image != null)
                                  Image.file(
                                    reportProvider.image!,
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
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: appBarColor,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
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
    );
  }
}
