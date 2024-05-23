import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:flutter/material.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EmergencySubmissionPage extends StatefulWidget {
//   const EmergencySubmissionPage({super.key});

//   @override
//   _EmergencySubmissionPageState createState() =>
//       _EmergencySubmissionPageState();
// }

// class _EmergencySubmissionPageState extends State<EmergencySubmissionPage> {

//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     EmergencyViewModel model = EmergencyViewModel();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: TitleWidget(text: "Soumission d'urgence"),
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
//                     color: appBarColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Nom',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: phoneController,
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
//                   value: selectedEmergencyType,
//                   items: emergencyTypes.map((type) {
//                     return DropdownMenuItem(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedEmergencyType = value;
//                     });
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
//                   controller: descriptionController,
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
//                     onPressed: getImageFromGallery,
//                     child: const Text('Ajouter une image'),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _image != null
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
//                               width: 300,
//                               height: 300,
//                               _image!,
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
//                   _currentPosition != null
//                       ? 'Localisation: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
//                       : 'Localisation non disponible',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: appBarColor,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       String name = nameController.text;
//                       String phone = phoneController.text;
//                       String emergencyType =
//                           selectedEmergencyType ?? 'Non spécifié';
//                       String description = descriptionController.text;
//                       String location = _currentPosition != null
//                           ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
//                           : 'Non spécifié';

//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text('Urgence soumise'),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text('Nom: $name\n'
//                                     'Numéro de téléphone: $phone\n'
//                                     'Type d\'urgence: $emergencyType\n'
//                                     'Description: $description\n'
//                                     'Localisation: $location\n'),
//                                 if (_image != null)
//                                   Image.file(
//                                     _image!,
//                                     height: 50,
//                                     width: 50,
//                                     fit: BoxFit.scaleDown,
//                                   ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () async {
//                                   var reportData = EmergencySubmission(
//                                     name: nameController.toString(),
//                                     phone: phoneController.toString(),
//                                     description:
//                                         descriptionController.toString(),
//                                     location: locationController.toString(),
//                                     emergencyType:
//                                         selectedEmergencyType.toString(),
//                                   );
//                                   // model.submitEmergency(reportData,_image).then(
//                                   //     (value) => Navigator.of(context).pop());
//                                 },
//                                 child: const Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       backgroundColor: appBarColor,
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

// A Counter example implemented with riverpod

class EmergencySubmissionPage extends ConsumerWidget {
  const EmergencySubmissionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportProvider = ref.watch(emergencyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(text: "Soumission d'urgence"),
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
                              width: 300,
                              height: 300,
                              reportProvider.image!,
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
                    onPressed: () {
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
                                onPressed: () async {
                                  reportProvider.submitEmergency().then(
                                      (value) => Navigator.of(context).pop());
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
