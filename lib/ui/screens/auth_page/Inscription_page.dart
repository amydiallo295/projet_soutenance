// // ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:emergency/utils/app_colors.dart';
// import 'package:emergency/utils/ui_helpers.dart';
// import 'package:emergency/viewModels/authentificationViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class InscriptionPage extends ConsumerStatefulWidget {
//   const InscriptionPage({super.key});

//   @override
//   _InscriptionPageState createState() => _InscriptionPageState();
// }

// class _InscriptionPageState extends ConsumerState<InscriptionPage> {
//   TextEditingController phoneController = TextEditingController(text: '+224');
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   bool _isPasswordVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     ref.read(authViewModelProvider).checkNetworkConnectivity();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = ref.watch(authViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: primaryColor),
//         title: TitleWidget(
//           text: "Inscription",
//           color: primaryColor,
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.app_registration,
//                           size: 100, color: primaryColor),
//                       const Text(
//                         'Emergency',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Pour vous connecter, un code de confirmation sera envoyé sur votre numéro de téléphone.',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black54,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 40),
//                       TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           labelText: 'Prénom et nom',
//                           prefixIcon:
//                               const Icon(Icons.person, color: Colors.blue),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Ce champ est obligatoire';
//                           }

//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           labelText: 'Numéro de téléphone',
//                           prefixIcon:
//                               const Icon(Icons.phone, color: Colors.blue),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(16),
//                           PhoneNumberInputFormatter(),
//                         ],
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Ce champ est obligatoire';
//                           }
//                           // Vérifier que le numéro de téléphone contient plus de 8 chiffres après le préfixe
//                           if (value.length <= 8 + 4) {
//                             // 4 caractères pour "+224"
//                             return 'Le numéro de téléphone doit contenir plus de 8 chiffres après le préfixe';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: !_isPasswordVisible,
//                         decoration: InputDecoration(
//                           labelText: 'Mot de passe',
//                           prefixIcon:
//                               const Icon(Icons.lock, color: Colors.blue),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.blue,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                             borderSide: const BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Ce champ est obligatoire';
//                           }
//                           if (value.length < 6) {
//                             return 'Le mot de passe doit contenir au moins 6 caractères';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 40),
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 300),
//                         child: isLoading
//                             ? const SpinKitCircle(
//                                 color: primaryColor,
//                                 size: 50.0,
//                               )
//                             : ElevatedButton(
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                         WidgetStateProperty.all(Colors.blue)),
//                                 onPressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     await authProvider
//                                         .checkNetworkConnectivity();
//                                     if (authProvider.connectivityResult ==
//                                         ConnectivityResult.none) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           duration: Duration(seconds: 1),
//                                           backgroundColor: Colors.grey,
//                                           content:
//                                               Text('Pas de connexion Internet'),
//                                         ),
//                                       );
//                                       return;
//                                     }
//                                     setState(() {
//                                       isLoading = true;
//                                     });

//                                     authProvider.sendToPhoneCode(
//                                       context,
//                                       phoneController.text,
//                                       nameController.text.trim(),
//                                       passwordController.text.trim(),
//                                     );

//                                     SharedPreferences prefs =
//                                         await SharedPreferences.getInstance();
//                                     await prefs.setString(
//                                         'password', passwordController.text);
//                                   }
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 },
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(0.0),
//                                   child: Text(
//                                     'Envoyer le code',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PhoneNumberInputFormatter extends TextInputFormatter {
//   static const String prefix = '+224';

//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (!newValue.text.startsWith(prefix)) {
//       final updatedText = prefix + newValue.text.replaceAll(prefix, '');
//       return TextEditingValue(
//         text: updatedText,
//         selection: TextSelection.fromPosition(
//           TextPosition(offset: updatedText.length),
//         ),
//       );
//     }

//     final selectionIndex = newValue.selection.end < prefix.length
//         ? prefix.length
//         : newValue.selection.end;

//     return TextEditingValue(
//       text: newValue.text,
//       selection: TextSelection.collapsed(offset: selectionIndex),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/viewModels/authentificationViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends ConsumerStatefulWidget {
  const InscriptionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends ConsumerState<InscriptionPage> {
  TextEditingController phoneController = TextEditingController(text: '+224');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    ref.read(authViewModelProvider).checkNetworkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryColor),
        title: TitleWidget(
          text: "Inscription",
          color: primaryColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.app_registration,
                          size: 100, color: primaryColor),
                      const Text(
                        'Emergency',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Pour vous connecter, un code de confirmation sera envoyé sur votre numéro de téléphone.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Prénom et nom',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(16),
                          PhoneNumberInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          // Vérifier que le numéro de téléphone contient plus de 8 chiffres après le préfixe
                          if (value.length <= 8 + 4) {
                            // 4 caractères pour "+224"
                            return 'Le numéro de téléphone doit contenir plus de 8 chiffres après le préfixe';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.blue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLoading
                            ? const SpinKitCircle(
                                color: primaryColor,
                                size: 50.0,
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.blue)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await authProvider
                                        .checkNetworkConnectivity();
                                    if (authProvider.connectivityResult ==
                                        ConnectivityResult.none) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 1),
                                          backgroundColor: Colors.grey,
                                          content:
                                              Text('Pas de connexion Internet'),
                                        ),
                                      );
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await authProvider.sendToPhoneCode(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      phoneController.text,
                                      nameController.text.trim(),
                                      passwordController.text.trim(),
                                    );

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'password', passwordController.text);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Envoyer le code',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    ],
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

class PhoneNumberInputFormatter extends TextInputFormatter {
  static const String prefix = '+224';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.startsWith(prefix)) {
      final updatedText = prefix + newValue.text.replaceAll(prefix, '');
      return TextEditingValue(
        text: updatedText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: updatedText.length),
        ),
      );
    }

    final selectionIndex = newValue.selection.end < prefix.length
        ? prefix.length
        : newValue.selection.end;

    return TextEditingValue(
      text: newValue.text,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
