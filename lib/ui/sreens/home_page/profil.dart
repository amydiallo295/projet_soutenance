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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        // centerTitle: true,
        title: TitleWidget(
          text: "Profil",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 30,
                        color: primaryColor,
                      ),
                      Text('Modifier', style: TextStyle(color: primaryColor)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildProfileDetail(
                        Icons.person,
                        currentUser?.displayName ?? '',
                      ),
                      const Divider(),
                      _buildProfileDetail(
                        Icons.phone,
                        currentUser?.phoneNumber ?? '',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  _showLogoutConfirmationDialog(context, ref);
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Se déconnecter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
        Icon(Icons.person, size: 100, color: primaryColor),
      ],
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
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey)),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red)),
              onPressed: () async {
                await ref
                    .read(profileViewModelProvider)
                    .signOut()
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false, // Supprime toutes les autres routes
                  );
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildProfileDetail(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            // color: Colors.grey,
          ),
          const Spacer(),
          SizedBox(
            width: 200,
            child: Text(
              overflow: TextOverflow.clip,
              value.toUpperCase(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
