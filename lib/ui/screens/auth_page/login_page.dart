// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency/ui/screens/auth_page/Inscription_page.dart';
import 'package:emergency/ui/screens/auth_page/reset_password.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/viewModels/authentificationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+224');
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 100, color: Colors.grey),
                  const Text(
                    ' Connexion à Emergency',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      prefixIcon: const Icon(Icons.phone, color: Colors.blue),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Veillez saisir votre mot de passe',
                      prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
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
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const ResetPasswordWithPhone(),
                          ),
                        );
                      },
                      child: const Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                                await authProvider.checkNetworkConnectivity();
                                if (authProvider.connectivityResult ==
                                    ConnectivityResult.none) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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

                                await authProvider
                                    .loginUserWithEmailAndPassword(
                                  phoneController.text.trim(),
                                  passwordController.text.trim(),
                                  // ignore: use_build_context_synchronously
                                  context,
                                );

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Text(
                                'Se connecter',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vous n\'avez pas de compte?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const InscriptionPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Inscrivez-vous',
                          style: TextStyle(color: Colors.black),
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
