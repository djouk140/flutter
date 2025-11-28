import 'package:agrico/pages/Inscript_Page.dart';
import 'package:agrico/pages/PresentPage.dart';
import 'package:agrico/pages/event_page.dart';
import 'package:agrico/Pay_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
        title: const Text(
          "Agrico au coeur du changement ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.PNG"),
            const Text(
              "Agrico",
              style: TextStyle(fontSize: 42, fontFamily: 'Poppins'),
            ),
            const Text(
              "Application pour acheter vos produits agricoles",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ), // meilleure pratique que Padding sans child
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.black87,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EventPage()),
                );
              },
              label: const Text(
                "Connexion",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              icon: const Icon(Icons.person_2_rounded, color: Colors.black26),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => InscriptPage()),
                    );
                  },
                  child: const Text(
                    "Sign-Up Now",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
