// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emergency/ui/screens/auth_page/Inscription_page.dart';
import 'package:emergency/ui/screens/auth_page/reset_password.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/viewModels/authentificationViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    'Emergency',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      if (!RegExp(r'^\+224\d+$').hasMatch(value)) {
                        return 'Numéro de téléphone invalide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Veillez saisir votre mot de passe',
                      prefixIcon: const Icon(Icons.lock, color: Colors.blue),
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
                              builder: (context) => const ResetPassword()),
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
                            key: const ValueKey('button'),
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
                                            Text('Pas de connexion Internet')),
                                  );
                                  return;
                                }

                                setState(() {
                                  isLoading = true;
                                });

                                await authProvider
                                    .loginUserWithEmailAndPassword(
                                  '${phoneController.text.trim()}@gmail.com',
                                  passwordController.text.trim(),
                                  context,
                                );

                                setState(() {
                                  isLoading = false;
                                });
                              }
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
                              'Se connecter',
                              style: TextStyle(color: Colors.white),
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
                                builder: (context) => const InscriptionPage()),
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
