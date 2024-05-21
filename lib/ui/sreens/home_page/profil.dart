import 'package:emergency/ui/sreens/emergencySettingsPage.dart';
import 'package:emergency/ui/sreens/home_page/emercencyHistoryPage.dart';
import 'package:emergency/ui/sreens/settingPage.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(
          text: "Profil",
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppBarColor, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildProfileDetail('Nom', 'John Doe'),
              const Divider(),
              _buildProfileDetail('Téléphone', '+123 456 7890'),
              const Divider(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Action pour modifier le profil
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
                  // Action pour naviguer vers les paramètres généraux
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPages(),
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

                  // Action pour naviguer vers les paramètres de notifications
                },
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Action pour se déconnecter
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Se déconnecter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppBarColor,
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
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.person,
            size: 90,
            color: Colors.white,
          ),
        ),
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
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
