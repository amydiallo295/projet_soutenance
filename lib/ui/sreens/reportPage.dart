// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:emergency/utils/app_colors.dart';
// import 'package:emergency/utils/ui_helpers.dart';
// import 'package:image_picker/image_picker.dart';

// class EmergencySubmissionPage extends StatefulWidget {
//   const EmergencySubmissionPage({super.key});

//   @override
//   _EmergencySubmissionPageState createState() =>
//       _EmergencySubmissionPageState();
// }

// class _EmergencySubmissionPageState extends State<EmergencySubmissionPage> {
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
//   File? _images;
//   final picker = ImagePicker();

//   Position? _currentPosition;
//   Future getimageGalerie() async {
//     final PickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );
//     setState(() {
//       if (PickedFile != null) {
//         _images = File(PickedFile.path);
//       } else {
//         print("no image picked");
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//               crossAxisAlignment: CrossAxisAlignment.stretch,
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
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     getimageGalerie();
//                   },
//                   child: const Text('Ajouter une image'),
//                 ),

//                 const SizedBox(height: 20),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     _getCurrentLocation();
//                 //   },
//                 //   child: const Text('Obtenir la localisation actuelle'),
//                 // ),
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
//                 ElevatedButton(
//                   onPressed: () {
//                     String name = nameController.text;
//                     String phone = phoneController.text;
//                     String emergencyType =
//                         selectedEmergencyType ?? 'Non spécifié';
//                     String description = descriptionController.text;
//                     String location = _currentPosition != null
//                         ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
//                         : 'Non spécifié';

//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Urgence soumise'),
//                           content: Text('Nom: $name\n'
//                               'Numéro de téléphone: $phone\n'
//                               'Type d\'urgence: $emergencyType\n'
//                               'Description: $description\n'
//                               'Localisation: $location\n'
//                               'images:$_images\n'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Text('OK'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     backgroundColor: appBarColor,
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   child: const Text(
//                     'Soumettre',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _getCurrentLocation() async {
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
//     setState(() {
//       _currentPosition = position;
//     });
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:image_picker/image_picker.dart';

class EmergencySubmissionPage extends StatefulWidget {
  const EmergencySubmissionPage({super.key});

  @override
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState extends State<EmergencySubmissionPage> {
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
  File? _image;
  final picker = ImagePicker();

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
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
                  value: selectedEmergencyType,
                  items: emergencyTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedEmergencyType = value;
                    });
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
                  controller: descriptionController,
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
                    onPressed: getImageFromGallery,
                    child: const Text('Ajouter une image'),
                  ),
                ),
                const SizedBox(height: 20),
                _image != null
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
                              _image!,
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
                  _currentPosition != null
                      ? 'Localisation: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
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
                      String name = nameController.text;
                      String phone = phoneController.text;
                      String emergencyType =
                          selectedEmergencyType ?? 'Non spécifié';
                      String description = descriptionController.text;
                      String location = _currentPosition != null
                          ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
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
                                if (_image != null)
                                  Image.file(
                                    _image!,
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

  Future<void> _getCurrentLocation() async {
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
    setState(() {
      _currentPosition = position;
    });
  }
}
