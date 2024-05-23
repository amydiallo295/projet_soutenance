import 'package:emergency/ui/sreens/politique_confidentialite.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class SettingsPages extends StatelessWidget {
  const SettingsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(text: "Paramètres"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Général',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              context,
              'Notifications',
              Icons.notifications,
              () {
                // Action à effectuer lors du clic sur "Notifications"
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              context,
              'Confidentialité',
              Icons.lock,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage()));

                // Action à effectuer lors du clic sur "Confidentialité"
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Préférences',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              context,
              'Thème',
              Icons.color_lens,
              () {
                // Action à effectuer lors du clic sur "Thème"
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              context,
              'Langue',
              Icons.language,
              () {
                // Action à effectuer lors du clic sur "Langue"
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
    );
  }
}
