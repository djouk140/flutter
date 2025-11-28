import 'package:flutter/material.dart';
import 'package:agrico/pages/Inscript_Page.dart';
import 'package:agrico/pages/PresentPage.dart';
import 'package:flutter/material.dart';
import '/pages/event_page.dart';
import '/pages/Inscript_Page.dart';
import 'package:agrico/Pay_page.dart';

class unknownPage extends StatelessWidget {
  const unknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Welcome to Agrico 2024",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.PNG"),
            const Text(
              "Agrico2024",
              style: TextStyle(fontSize: 42, fontFamily: 'Poppins'),
            ),
            const Text(
              "Application pour commercialiser vos produits agricoles by Hector Kombou",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EventPage()),
                );
              },
              label: Text(
                "Connexion",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              icon: Icon(Icons.person_2_rounded),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsetsDirectional.all(50.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InscriptPage()),
                      );
                    },
                    child: Text(
                      "Sign-Up Now",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
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
