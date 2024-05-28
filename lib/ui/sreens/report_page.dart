import 'package:emergency/providers/emergency_submission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencySubmissionPage extends ConsumerWidget {
  const EmergencySubmissionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final emergencyViewModel = ref.watch(emergencyProvider.notifier);
    final getCurrentPosition =
        ref.read(currentPositionProvider.notifier).getCurrentLocation();
    final formState = ref.watch(emergencyFormProvider);
    final selectedImage = ref.watch(selectedImageProvider);
    final currentPosition = ref.watch(currentPositionProvider);
    final emergencyNotifier = ref.watch(emergencyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(emergencyFormProvider.notifier).updateName(value);
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(emergencyFormProvider.notifier).updatePhone(value);
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: ref.watch(emergencyFormProvider).selectedEmergencyType,
                  items: [
                    'Incendie',
                    'Accident de la route',
                    'Crime',
                    'Urgence médicale',
                    'Catastrophe naturelle',
                    'Autre'
                  ].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != '') {
                      ref
                          .read(emergencyFormProvider.notifier)
                          .updateEmergencyType(value);
                    }
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
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        ref
                            .read(emergencyFormProvider.notifier)
                            .updateDescription(value);
                      }
                    }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(selectedImageProvider.notifier)
                          .getImageFromGallery();
                      debugPrint("Selected image button get pressed");
                    },
                    child: const Text('Ajouter une image'),
                  ),
                ),
                const SizedBox(height: 20),
                selectedImage != null
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
                              selectedImage,
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
                  currentPosition != null
                      ? 'Localisation: ${currentPosition.latitude}, ${currentPosition.longitude}'
                      : 'Localisation non disponible',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // await emergencyViewModel.submitEmergency();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Urgence soumise'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Nom: ${formState.name}\n'
                                  'Numéro de téléphone: ${formState.phone}\n'
                                  'Type d\'urgence: ${formState.selectedEmergencyType}\n'
                                  'Description: ${formState.description}\n'
                                  'Localisation: ${currentPosition != null ? '${currentPosition.latitude}, ${currentPosition.longitude}' : 'Non disponible'}\n',
                                ),
                                if (selectedImage != null)
                                  Image.file(
                                    selectedImage,
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
                      //reset form
                      emergencyNotifier.formState.resetFields();
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
