import 'package:agrico/Notif_page.dart';
import 'package:agrico/Profil_Page.dart';
import 'package:agrico/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:agrico/Accueil_page.dart';
import 'package:agrico/Mess_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrico/pages/home_page.dart';
import 'package:agrico/Pay_page.dart';

class PresentPage extends StatefulWidget {
  @override
  _PresentPageState createState() => _PresentPageState();
}

class _PresentPageState extends State<PresentPage> {
  int _currentIndex = 0;
  User? _currentUser;

  final List<String> _carouselImages = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Accueil_page(),
      Mess_Page(user: _currentUser), // ✅ plus de fallback inutile
      Notif_page(),
      ProfilePage(),
      EventPage(),
      HomePage(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(automaticallyImplyLeading: false),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildIconButtonWithLabel(Icons.home, 'Accueil', 0),
            _buildIconButtonWithLabel(Icons.message, 'chatbot', 1),
            _buildIconButtonWithLabel(
              Icons.keyboard_command_key_sharp,
              'Vente',
              2,
            ),
            _buildIconButtonWithLabel(Icons.account_circle, 'Profil', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButtonWithLabel(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? Colors.green : Colors.black,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items:
          _carouselImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
    );
  }
}
