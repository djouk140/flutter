import 'package:agrico/Pay_page.dart';
import 'package:flutter/material.dart';
import 'package:agrico/Accueil_page.dart';
import 'package:agrico/Mess_page.dart';
import 'package:agrico/Notif_page.dart';
import 'package:agrico/Profil_page.dart';
import 'package:agrico/pages/Inscript_Page.dart';
import 'package:agrico/pages/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/pages/event_page.dart';
import 'package:agrico/Pay_page.dart';

class Accueil_page extends StatelessWidget {
  final List<Map<String, String>> slides = [
    {"image": "assets/images/image1.jpg", "text": "La terre ne ment pas"},
    {
      "image": "assets/images/image2.jpg",
      "text": "Des Oranges de très bon pris chez AGRICO",
    },
    {
      "image": "assets/images/image3.jpg",
      "text": "Des bonnes récoltes du café en toute surété",
    },
    {
      "image": "assets/images/image4.jpg",
      "text": "                                 Des Arachides de bonne qualité",
    },
    {
      "image": "assets/images/image5.jpg",
      "text": "Une très bonne culture de bananes et plantains ",
    },
    {
      "image": "assets/images/image6.jpg",
      "text": "Commandez vos Papayes directement chez un fournisseur compétent",
    },
    {
      "image": "assets/images/image7.webp",
      "text": "Des pastèques juteuses et très agréables",
    },
    {
      "image": "assets/images/image8.webp",
      "text": "Une très bonne production du Cacao",
    },
    {
      "image": "assets/images/image9.jpg",
      "text":
          "Commandez vos Ananas directement chez un producteur et fournisseur agréer",
    },
    {
      "image": "assets/images/image10.png",
      "text":
          "Commandez vos produits directement chez un producteur en toute sécurité",
    },
    {
      "image": "assets/images/image11.jpg",
      "text": "Commandez vos Avocats à un prix réduit et satisfaisant",
    },
    {
      "image": "assets/images/image12.jpg",
      "text": "Commandez vos Mandarines directement chez le AGRICO",
    },
    {
      "image": "assets/images/image13.jpg",
      "text": "Commandez vos Manioc chez un fournisseur agréer",
    },
    {
      "image": "assets/images/image14.jpg",
      "text": "Des Mangues juteuses et de très bonne qualité",
    },
    {
      "image": "assets/images/image15.jpg",
      "text": "Des citrons juteux et de très bonne qualité",
    },
    {
      "image": "assets/images/image16.jpg",
      "text": "De la canne à sucre juteuses et de très bonne qualité",
    },
    {
      "image": "assets/images/image17.jpg",
      "text": "De très beaux tournesols en vente chez AGRICO",
    },
    {
      "image": "assets/images/image18.jpg",
      "text": "Du haricots de très bonne qualité",
    },
    {
      "image": "assets/images/image19.jpg",
      "text": "Du Mais directement chez un producteur et fournisseur agréer",
    },
    {
      "image": "assets/images/image20.jpg",
      "text": "la terre est tout ce qui nous reste de sacré",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Agrico",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Tous en avant vers la transformation et le developpement de l'agriculture",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SizedBox(height: 50),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items:
                          slides.map((slide) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(slide["image"]!),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      right: 20,
                                      child: Text(
                                        slide["text"]!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 50),
                    MaterialButton(
                      minWidth: 150,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pay_page()),
                        );
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Commencer",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
