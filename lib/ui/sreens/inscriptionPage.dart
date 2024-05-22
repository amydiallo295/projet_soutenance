import 'package:emergency/ui/sreens/login_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScren extends StatefulWidget {
  const RegistrationScren({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScren createState() => _RegistrationScren();
}

class _RegistrationScren extends State<RegistrationScren> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _revalidatePasController =
      TextEditingController();

  void _submit() {
    // Handle form submission here
    String email = _emailController.text;
    String password = _passwordController.text;
    // Perform necessary actions like validation and API calls
    print('Email: $email, Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Inscription',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nom et Prenom',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _phoneController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                obscureText: true,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _revalidatePasController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                      setState(() {
                        // Ajoutez ici votre logique pour mettre à jour l'état de la case à cocher
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.white,

                    // Cette propriété définit la couleur de la coche
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Acceptez-vous les règles de confidentialité ?',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.black,
                ),
                child: Text('S\'inscrire'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Vous avez deja un compte?',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));

                        // Action pour les conseils
                      },
                      child: Text('connecter vous',
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
