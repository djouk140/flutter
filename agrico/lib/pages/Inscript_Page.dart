import 'package:agrico/pages/PresentPage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/pages/auth_service.dart';
import '/pages/signup_controller.dart';
import '/pages/user_model.dart';
import '/pages/Inscript_Page.dart';

class InscriptPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<InscriptPage> {
  bool showpass = true;

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final _usernameController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String selectedProfileType = '0';

  final SignupController _signupController = SignupController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFf4fcfa),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF587259),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.black, size: 100),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nom d\'utilisateur',
                      hintText: 'Entrer votre nom',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom d\'utilisateur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  IntlPhoneField(
                    controller: _telephoneController,
                    decoration: InputDecoration(
                      labelText: 'Téléphone',
                      hintText: 'Entrer votre numéro de téléphone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (phoneNumber) {
                      if (_telephoneController.value.text.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Adresse Email',
                      hintText: 'Entrer votre adresse email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre adresse email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Veuillez entrer une adresse email valide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: showpass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showpass = !showpass;
                          });
                        },
                        icon:
                            showpass
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                      ),
                      labelText: 'Mot de Passe',
                      hintText: 'Entrer un mot de passe',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(
                        value: '1',
                        child: Text("Agriculteur/Marchant"),
                      ),
                      DropdownMenuItem(value: '0', child: Text("Acheteurs")),
                    ],
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: selectedProfileType,
                    onChanged: (value) {
                      setState(() {
                        selectedProfileType = value!;
                      });
                    },
                  ),
                  SizedBox(height: 100),
                  MaterialButton(
                    minWidth: 170,
                    height: 50,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    color: Color(0xFFC4E7C5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    String username = _usernameController.text;
    String telephone = _telephoneController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Le mot de passe doit contenir au moins 6 caractères'),
        ),
      );
      return;
    }

    try {
      //  bool emailExists = await _authService.checkIfEmailExists(email);
      //  if (emailExists) {
      //    ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('L\'adresse email existe déjà')),
      //   );
      //  return;
      // }

      User? firebaseUser = await _authService.signUpWithEmail(email, password);

      if (firebaseUser != null) {
        UserModel userModel = UserModel(
          username: username,
          telephone: telephone,
          email: email,
          password: password,
          profileType: selectedProfileType,
        );

        await _signupController.registerUser(context, userModel);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PresentPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
      );
    }
  }
}
