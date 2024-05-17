// import 'package:emergency/ui/sreens/emergencySettingsPage.dart';
// import 'package:flutter/material.dart';

// class ProfilePage2 extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage2> {
//   String _userName = 'Utilisateur';
//   String _userEmail = 'utilisateur@example.com';
//   String _userPhoneNumber = '123456789';

//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();

//   @override
//   void initState() {
//     _nameController.text = _userName;
//     _emailController.text = _userEmail;
//     _phoneController.text = _userPhoneNumber;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Profil'),
//       // ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),
//             const CircleAvatar(
//               radius: 100.0,
//               backgroundColor: Colors.transparent,
//               backgroundImage: AssetImage("assets/images/logoApp.png"),
//               //child: Image(image: AssetImage("assets/images/logoApp.png")),
//             ),
//             SizedBox(height: 8),
//             SizedBox(height: 30),
//             Text(
//               'Informations du Profil',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Nom'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Téléphone'),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _userName = _nameController.text;
//                   _userEmail = _emailController.text;
//                   _userPhoneNumber = _phoneController.text;
//                   // Ajoutez ici la logique pour enregistrer les modifications du profil
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text('Profil mis à jour'),
//                 ));
//               },
//               child: Text('Enregistrer les modifications'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SettingsPage()),
//                 );
//               },
//               icon: const Icon(Icons.settings),
//               label: const Text(
//                 'Praramtre',
//                 style: TextStyle(color: Color.fromARGB(255, 230, 43, 29)),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Ajouter la logique pour choisir une image
//               },
//               child: Text(
//                 'se deconecter',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
