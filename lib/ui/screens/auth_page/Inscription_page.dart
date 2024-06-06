// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/viewModels/authentificationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class InscriptionPage extends ConsumerStatefulWidget {
  const InscriptionPage({super.key});

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends ConsumerState<InscriptionPage> {
  TextEditingController phoneController = TextEditingController(text: '+224');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
                    children: [
                      const Icon(Icons.person, size: 100, color: Colors.grey),
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
                          if (!RegExp(r'^\+224\d+$').hasMatch(value)) {
                            return 'Numéro de téléphone invalide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.blue),
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
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: isLoading
                            ? const SpinKitCircle(
                                color: primaryColor,
                                size: 50.0,
                              )
                            : ElevatedButton(
                                key: const ValueKey('button'),
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
                                            content: Text(
                                                'Pas de connexion Internet')),
                                      );
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await authProvider.sendToPhoneCode(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      phoneController.text.trim(),
                                      nameController.text.trim(),
                                      passwordController.text.trim(),
                                    );

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString('password',
                                        passwordController.text.trim());
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 30.0,
                                  ),
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
                                  'Envoyer le code',
                                  style: TextStyle(color: Colors.white),
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
