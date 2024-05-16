import 'package:emergency/ui/sreens/emergencyInformationPage.dart';
import 'package:emergency/ui/sreens/emergencyProfilePage.dart';
import 'package:emergency/ui/sreens/emergencyReportPage.dart';
import 'package:emergency/ui/sreens/emergencySettingsPage.dart';
import 'package:emergency/ui/sreens/emergencyallPage.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyReportPage()),
                );
              },
              icon: Icon(Icons.report),
              label: Text('Signaler une urgence'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyCallPage()),
                );
              },
              icon: Icon(Icons.call),
              label: Text('Appeler les services d\'urgence'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationPage()),
                    );
                  },
                  child: Text('Informations'),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  child: Text('Parametre'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
