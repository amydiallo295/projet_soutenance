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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(290),
        child: AppBar(
          flexibleSpace: Container(
            child: Container(
              child: Image(image: AssetImage("assets/images/logo.png")),
              //  Image.asset("assets/images/emergencylogo.png"),
            ),
            //child: const Center(child: Text("Emergency",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 13, 177, 241),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
/**            child: Image(
              width: double.infinity,
              image: AssetImage("assets/images/emergency2.png"),
            ), */
          ),
        ),

        //  title: Text('Emergency '),
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
              icon: const Icon(Icons.report),
              label: const Text(
                'Signaler une urgence',
                style: TextStyle(color: Color.fromARGB(255, 230, 43, 29)),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyCallPage()),
                );
              },
              icon: const Icon(Icons.call),
              label: const Text(
                'Appeler un service   ',
                style: TextStyle(color: Color.fromARGB(255, 230, 43, 29)),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            /** Row(
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
            ), */
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.red, // Couleur du fond
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage2()),
                );
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationPage()),
                );
              },
              icon: const Icon(Icons.newspaper_outlined),
            ),
/**            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Text('Parametre'),
            ), */
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage2()),
                );
              },
              icon: const Icon(Icons.person,),
            ),
          ],
        ),
      ),
    );
  }
}
