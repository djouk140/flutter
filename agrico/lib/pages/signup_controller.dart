import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/user_model.dart';
import '../Pages/home_page.dart';

class SignupController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var username = TextEditingController();
  var email = TextEditingController();

  Future<void> registerUser(BuildContext context, UserModel user) async {
    try {
      await _firestore.collection('Users').add(user.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription réussie. Bienvenue!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
      );
    }
  }
}
