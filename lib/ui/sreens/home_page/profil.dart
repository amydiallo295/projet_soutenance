import 'package:emergency/routers/routes.dart';
import 'package:emergency/ui/screens/auth_page/login_page.dart';
import 'package:emergency/ui/sreens/home_page/profil/edit_profil_page.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/viewModels/profileviewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/ui/sreens/home_page/emercency_history_page.dart';
import 'package:emergency/ui/sreens/setting_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.watch(profileViewModelProvider);
    final currentUser = profileViewModel.currentUser;

    print("voir les users💪💪💪💪💪💪💪 ${currentUser}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: TitleWidget(
          text: "Profil",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildProfileDetail('Nom', currentUser?.displayName ?? ''),
              const Divider(),
              _buildProfileDetail('Téléphone', currentUser?.phoneNumber ?? ''),
              const Divider(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  print("voir les users💪💪💪💪💪💪💪 ${currentUser}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: const Text(
                  'Modifier le profil',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres', style: TextStyle(fontSize: 14)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPages(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.history),
                title:
                    const Text('Historiques', style: TextStyle(fontSize: 14)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  print('fonction de deconnexion⛪⛪⛪⛪⛪⛪⛪');
                  _showLogoutConfirmationDialog(context, ref
                      // profileViewModel.signOut

                      );
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Se déconnecter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Column(
      children: [
        Icon(Icons.person, size: 100, color: Colors.grey),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Déconnexion',
            style: TextStyle(color: primaryColor, fontSize: 18),
          ),
          content: const Text('Voulez-vous vraiment vous déconnecter ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler',
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Déconnexion',
                  style: TextStyle(color: Colors.red, fontSize: 18)),
              onPressed: () {
                print('devvvvvvv😁😁😁😁😁😁😁😁');
                ref.read(profileViewModelProvider).signOut().then((value) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
