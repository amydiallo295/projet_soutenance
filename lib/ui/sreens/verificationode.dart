// import 'package:emergency/viewModels/authentificationViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EnterCodePage extends ConsumerStatefulWidget {
//   final String verificationId;
//   final String phoneNumber;
//   final String userName;

//   const EnterCodePage(
//       {super.key,
//       required this.verificationId,
//       required this.phoneNumber,
//       required this.userName});

//   @override
//   // ignore: library_private_types_in_public_api
//   _EnterCodePageState createState() => _EnterCodePageState();
// }

// class _EnterCodePageState extends ConsumerState<EnterCodePage> {
//   final TextEditingController codeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = ref.watch(authViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Entrer le Code de Confirmation'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: codeController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.lock, color: Colors.blue),
//                 labelText: 'Code de confirmation',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 authProvider.userCodeVerifyToLogin(
//                   widget.verificationId,
//                   widget.userName,
//                   codeController.text.trim(),
//                   widget.phoneNumber,
//                   context,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 15.0, horizontal: 30.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 backgroundColor: Colors.blue,
//                 textStyle: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               child: const Text(
//                 'Vérifier le Code',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:emergency/utils/app_colors.dart';
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
        title: const Text('Entrer le Code de Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                labelText: 'Code de confirmation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading // Show loading spinner if isLoading is true
                ? const SpinKitCircle(
                    color: primaryColor,
                    size: 50.0,
                  )
                : ElevatedButton(
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
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
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
                      'Vérifier le Code',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
