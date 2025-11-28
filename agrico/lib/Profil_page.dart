import 'package:agrico/Accueil_page.dart';
import 'package:agrico/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:agrico/Notif_page.dart';
import 'package:agrico/pages/PresentPage.dart';
import 'package:agrico/profil_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'Edit_profil.dart'; // Assurez-vous que ce fichier existe

import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

// Exemple de pages vers lesquelles rediriger
import 'Edit_profil.dart';
import 'Notif_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;

  /// Sélection depuis galerie ou caméra (mobile)
  Future<void> pickImageMobile(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final imgBytes = await image.readAsBytes();
      setState(() {
        _image = imgBytes;
      });
    }
  }

  /// Sélection d'un fichier image depuis l'ordinateur (web/desktop)
  Future<void> pickImageFromPC() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        setState(() {
          _image = fileBytes;
        });
      } else {
        // Si on est sur desktop/mobile, on peut lire depuis le chemin du fichier
        final file = File(result.files.first.path!);
        setState(() {
          _image = file.readAsBytesSync();
        });
      }
    }
  }

  /// Boîte de dialogue pour choisir la source
  void selectImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.white),
                title: const Text(
                  "Choisir depuis la galerie",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImageMobile(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  "Prendre une photo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImageMobile(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.computer, color: Colors.white),
                title: const Text(
                  "Importer depuis l'ordinateur",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromPC();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Menu Item
  Widget buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white70,
        size: 18,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [
              // Photo de profil
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                        radius: 60,
                        backgroundImage: MemoryImage(_image!),
                      )
                      : const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/profil.jpg"),
                      ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Hector KOMBOU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "djoukwekombou9@gmail.com",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),

              // Boutons du menu
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1B263B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    buildMenuItem(
                      icon: Icons.edit,
                      text: "Modifier le profil",
                      onTap: () async {
                        try {
                          // Navigation corrigée vers EditProfile avec gestion d'erreur
                          await Get.to(() => const EditProfile());
                        } catch (e) {
                          print('Erreur de navigation: $e');
                          // Navigation alternative si la première échoue
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        }
                      },
                    ),
                    buildMenuItem(
                      icon: Icons.collections,
                      text: "A propos de l'application",
                      onTap: () => Get.to(() => PresentPage()),
                    ),
                    buildMenuItem(
                      icon: Icons.block,
                      text: "Utilisateurs bloqués",
                      onTap: () => Get.to(() => const Notif_page()),
                    ),
                    buildMenuItem(
                      icon: Icons.settings,
                      text: "Paramètres",
                      onTap: () {
                        Get.to(() => const Notif_page());
                      },
                    ),
                    buildMenuItem(
                      icon: Icons.logout,
                      text: "Déconnexion",
                      onTap: () {
                        Get.offAll(() => PresentPage());
                      },
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
