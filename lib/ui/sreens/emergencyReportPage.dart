import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'dart:io';

class EmergencyReportPage extends StatefulWidget {
  @override
  _EmergencyReportPageState createState() => _EmergencyReportPageState();
}

class _EmergencyReportPageState extends State<EmergencyReportPage> {
  String _selectedEmergencyType = '';
  final TextEditingController _detailsController = TextEditingController();
  final ImagesPicker _picker = ImagesPicker();
  List<XFile>? _imageFiles = [];

  void _submitReport() {
    if (_selectedEmergencyType.isNotEmpty &&
        _detailsController.text.isNotEmpty &&
        (_imageFiles != null && _imageFiles!.isNotEmpty)) {
      // Submit the report logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rapport d\'urgence soumis.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir toutes les informations.')),
      );
    }
  }

  Future<void> _pickImages() async {
    try {
      // final List<XFile>? pickedFiles = await _picker.pi;
      //if (pickedFiles != null) {
      //setState(() {
      //_imageFiles = pickedFiles;
      //});
      //}
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection des images.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Signaler une Urgence',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Text(
              'Sélectionnez le type d\'urgence :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedEmergencyType.isEmpty
                  ? null
                  : _selectedEmergencyType,
              hint: Text('Choisissez un type d\'urgence'),
              items: <String>['Incendie', 'Accident', 'Médical', 'Criminalité']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEmergencyType = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _detailsController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Détails supplémentaires',
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: ElevatedButton(
                onPressed: _pickImages,
                child: Text('Ajouter des images'),
              ),
            ),
            _imageFiles != null && _imageFiles!.isNotEmpty
                ? Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _imageFiles!.map((XFile image) {
                      return Image.file(File("image"), width: 100, height: 100);
                    }).toList(),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: ElevatedButton(
                onPressed: _submitReport,
                child: Text(
                  'Soumettre',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class XFile {}
