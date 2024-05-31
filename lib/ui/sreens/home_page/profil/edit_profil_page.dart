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
                decoration: const InputDecoration(labelText: 'Nom'),
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
                decoration: const InputDecoration(labelText: 'Téléphone'),
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
