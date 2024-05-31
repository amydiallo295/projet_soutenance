// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:emergency/viewModels/viewModelReport.dart';

// class EmergencySubmissionPage extends ConsumerStatefulWidget {
//   const EmergencySubmissionPage({Key? key}) : super(key: key);

//   @override
//   _EmergencySubmissionPageState createState() =>
//       _EmergencySubmissionPageState();
// }

// class _EmergencySubmissionPageState
//     extends ConsumerState<EmergencySubmissionPage> {
//   @override
//   Widget build(BuildContext context) {
//     final emergencyViewModel = ref.watch(emergencyViewModelProvider);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text("Soumission d'urgence"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Soumettre une nouvelle urgence',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: emergencyViewModel.nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Nom',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: emergencyViewModel.phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Numéro de téléphone',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: emergencyViewModel.selectedEmergencyType,
//                   items: emergencyViewModel.emergencyTypes.map((type) {
//                     return DropdownMenuItem(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     emergencyViewModel.setEmergencyType(value);
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Type d\'urgence',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: emergencyViewModel.descriptionController,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: emergencyViewModel.getImageFromGallery,
//                     child: const Text('Ajouter une image'),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 emergencyViewModel.image != null
//                     ? SizedBox(
//                         width: 200,
//                         child: Container(
//                           height: 300,
//                           width: 200,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12.0),
//                             child: Image.file(
//                               emergencyViewModel.image!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       )
//                     : const Text(
//                         'Aucune image sélectionnée',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                 const SizedBox(height: 20),
//                 Text(
//                   emergencyViewModel.currentPosition != null
//                       ? 'Localisation: ${emergencyViewModel.currentPosition!.latitude}, ${emergencyViewModel.currentPosition!.longitude}'
//                       : 'Localisation non disponible',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       await emergencyViewModel.submitEmergency();
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text('Urgence soumise'),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   'Nom: ${emergencyViewModel.nameController.text}\n'
//                                   'Numéro de téléphone: ${emergencyViewModel.phoneController.text}\n'
//                                   'Type d\'urgence: ${emergencyViewModel.selectedEmergencyType}\n'
//                                   'Description: ${emergencyViewModel.descriptionController.text}\n'
//                                   'Localisation: ${emergencyViewModel.currentPosition != null ? '${emergencyViewModel.currentPosition!.latitude}, ${emergencyViewModel.currentPosition!.longitude}' : 'Non disponible'}\n',
//                                 ),
//                                 if (emergencyViewModel.image != null)
//                                   Image.file(
//                                     emergencyViewModel.image!,
//                                     height: 50,
//                                     width: 50,
//                                     fit: BoxFit.scaleDown,
//                                   ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                       emergencyViewModel
//                           .resetFields(); // Réinitialiser les champs après la soumission
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       backgroundColor: Colors.blue,
//                       textStyle: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     child: const Text(
//                       'Soumettre',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emergency/viewModels/viewModelReport.dart';

class EmergencySubmissionPage extends ConsumerStatefulWidget {
  const EmergencySubmissionPage({Key? key}) : super(key: key);

  @override
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState
    extends ConsumerState<EmergencySubmissionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emergencyViewModel = ref.watch(emergencyViewModelProvider);

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
            child: Form(
              key: _formKey,
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
                  DropdownButtonFormField<String>(
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
                    controller: emergencyViewModel.descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La description est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: emergencyViewModel.getImageFromGallery,
                      child: const Text('Ajouter une image'),
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
                          style: TextStyle(color: Colors.red),
                        ),
                  const SizedBox(height: 20),
                  Text(
                    emergencyViewModel.currentPosition != null
                        ? 'Localisation: ${emergencyViewModel.currentPosition!.latitude}, ${emergencyViewModel.currentPosition!.longitude}'
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
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          emergencyViewModel
                              .resetFields(); // Réinitialiser les champs après la soumission
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
      ),
    );
  }
}
