import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:emergency/utils/app_colors.dart';

class EmergencySubmissionPage extends ConsumerStatefulWidget {
  const EmergencySubmissionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencySubmissionPageState createState() =>
      _EmergencySubmissionPageState();
}

class _EmergencySubmissionPageState
    extends ConsumerState<EmergencySubmissionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final emergencyViewModel = ref.read(emergencyViewModelProvider);
      emergencyViewModel.resetCurrentImage();
      emergencyViewModel.nameController.clear();
      emergencyViewModel.phoneController.text = '+224';
      emergencyViewModel.descriptionController.clear();
      emergencyViewModel.setEmergencyType(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final emergencyViewModel = ref.watch(emergencyViewModelProvider);
    final isLoading = emergencyViewModel.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Soumission d'urgence",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: primaryColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emergency,
                            size: 30,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Soumettre une nouvelle urgence',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Type d\'urgence'),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              iconSize: 30.0,
                              iconEnabledColor: primaryColor,
                              value: emergencyViewModel.selectedEmergencyType,
                              items:
                                  emergencyViewModel.emergencyTypes.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                emergencyViewModel.setEmergencyType(value);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le type d\'urgence est obligatoire';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Informations personnelles'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: emergencyViewModel.nameController,
                              label: 'Nom complet',
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le nom est obligatoire';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: emergencyViewModel.phoneController,
                              label: 'Numéro de téléphone',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                if (!value.startsWith('+224')) {
                                  emergencyViewModel.phoneController.text =
                                      '+224';
                                  emergencyViewModel.phoneController.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset: emergencyViewModel
                                            .phoneController.text.length),
                                  );
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le numéro de téléphone est obligatoire';
                                }
                                if (!value.startsWith('+224')) {
                                  return 'Le numéro doit commencer par +224';
                                }
                                if (value.length <= 12) {
                                  return 'Numéro invalide';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Description de l\'urgence'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller:
                                  emergencyViewModel.descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                hintText: 'Décrivez la situation d\'urgence...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Image Section
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Photo de la situation'),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                              onPressed: emergencyViewModel.getImageFromGallery,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              label: const Text(
                                'Ajouter une photo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (emergencyViewModel.image != null)
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    emergencyViewModel.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Aucune image sélectionnée',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await emergencyViewModel.submitEmergency();
                                  if (!mounted) return;
                                  _showSuccessDialog(
                                      context, emergencyViewModel);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'SOUMETTRE L\'URGENCE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      validator: validator,
    );
  }

  void _showSuccessDialog(BuildContext context, dynamic emergencyViewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600]),
              const SizedBox(width: 8),
              const Text('Urgence soumise'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Nom', emergencyViewModel.nameController.text),
                _buildInfoRow(
                    'Téléphone', emergencyViewModel.phoneController.text),
                _buildInfoRow(
                    'Type', emergencyViewModel.selectedEmergencyType ?? ''),
                _buildInfoRow('Description',
                    emergencyViewModel.descriptionController.text),
                if (emergencyViewModel.currentPosition != null)
                  _buildInfoRow(
                    'Localisation',
                    '${emergencyViewModel.currentPosition!.latitude}, ${emergencyViewModel.currentPosition!.longitude}',
                  ),
                if (emergencyViewModel.image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        emergencyViewModel.image!,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                emergencyViewModel.nameController.clear();
                emergencyViewModel.phoneController.clear();
                emergencyViewModel.descriptionController.clear();
                emergencyViewModel.resetCurrentImage();
                emergencyViewModel.setEmergencyType(null);
                emergencyViewModel.resetCurrentPosition();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
