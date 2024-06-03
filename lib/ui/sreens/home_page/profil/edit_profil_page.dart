import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/viewModels/profileviewModel.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    final profileViewModel = ref.read(profileViewModelProvider);
    _nameController = TextEditingController(
        text: profileViewModel.currentUser?.displayName ?? '');
    _phoneController = TextEditingController(
        text: profileViewModel.currentUser?.phoneNumber ?? '');
    _passwordController = TextEditingController();
    if (!_phoneController.text.startsWith('+224')) {
      _phoneController.text = '+224${_phoneController.text}';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = ref.read(profileViewModelProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: TitleWidget(text: "Modifier le profil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nouveau nom',
                  // prefixIcon: const Icon(Icons.person, color: Colors.blue),
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
                    return 'Le nom est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nouveau téléphone',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le téléphone est obligatoire';
                  }
                  if (!value.startsWith('+224')) {
                    return 'Le numéro de téléphone doit commencer par +224';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_phoneController.text !=
                        profileViewModel.currentUser?.phoneNumber) {
                      // Vérifier le numéro de téléphone
                      profileViewModel.verifyPhoneNumber(
                        _phoneController.text,
                        (verificationId) {
                          setState(() {
                            _verificationId = verificationId;
                          });
                        },
                      );
                    } else {
                      // Mettre à jour le profil
                      await profileViewModel
                          .updateUserProfile(
                            displayName: _nameController.text,
                            phoneNumber: _phoneController.text,
                            userPassword: _passwordController.text,
                          )
                          .whenComplete(() => Navigator.pop(context));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (_verificationId != null) ...[
                const SizedBox(height: 20),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Code de vérification'),
                  onChanged: (code) async {
                    if (code.length == 6) {
                      // Confirmer le numéro de téléphone
                      await profileViewModel
                          .updatePhoneNumberWithCode(
                            _verificationId!,
                            code,
                          )
                          .whenComplete(() => Navigator.pop(context));
                    }
                  },
                ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   decoration:
                //       const InputDecoration(labelText: 'Nouveau mot de passe'),
                //   onChanged: (password) async {
                //     // Confirmer le numéro de téléphone
                //     await profileViewModel
                //         .updateUserPassword(
                //           password,
                //         )
                //         .whenComplete(() => Navigator.pop(context));
                //   },
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
