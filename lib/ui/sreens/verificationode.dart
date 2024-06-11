import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/viewModels/authentificationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the loading spinner package

class EnterCodePage extends ConsumerStatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String userName;
  final String userPassword;

  const EnterCodePage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.userName,
    required this.userPassword,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EnterCodePageState createState() => _EnterCodePageState();
}

class _EnterCodePageState extends ConsumerState<EnterCodePage> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false; // Add a loading state

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: primaryColor),
          title: TitleWidget(
            text: 'Entrer le Code de Confirmation',
          )
          //  const Text('Entrer le Code de Confirmation'),
          ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Code de confirmation',
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
                if (value.length != 6) {
                  return 'Code invalide';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            isLoading // Show loading spinner if isLoading is true
                ? const SpinKitCircle(
                    color: primaryColor,
                    size: 50.0,
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue)),
                    onPressed: () async {
                      setState(() {
                        isLoading = true; // Set loading state to true
                      });
                      await authProvider.userCodeVerifyToLogin(
                        widget.verificationId,
                        widget.userName,
                        codeController.text.trim(),
                        widget.phoneNumber,
                        widget.userPassword,
                        context,
                      );
                      setState(() {
                        isLoading = false; // Set loading state to false
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'Vérifier le Code',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
