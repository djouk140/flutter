import 'package:agrico/Profil_page.dart';
import 'package:agrico/pages/PresentPage.dart';
import 'package:get/get.dart';
import 'pages/user_model.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agrico/Pay_page.dart';
import 'pages/signup_controller.dart';
import 'pages/user_model.dart';

class SignupController extends GetxController {
  var username = TextEditingController();
  var email = TextEditingController();
  var telephone = TextEditingController();
  var password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Vous pouvez initialiser les contrôleurs ici si nécessaire
  }

  @override
  void onClose() {
    // Dispose les contrôleurs pour éviter les fuites de mémoire
    username.dispose();
    email.dispose();
    telephone.dispose();
    password.dispose();
    super.onClose();
  }

  // Méthode de déconnexion ajoutée
  Future<void> logout() async {
    try {
      // Effacer les données utilisateur stockées (SharedPreferences, cache, etc.)
      // Exemple avec SharedPreferences si vous l'utilisez :
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.clear();

      // Ou effacer seulement les données spécifiques :
      // await prefs.remove('user_token');
      // await prefs.remove('user_data');

      // Effacer les contrôleurs
      username.clear();
      email.clear();
      telephone.clear();
      password.clear();

      print('Utilisateur déconnecté avec succès');
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
      throw e;
    }
  }

  Future<UserModel> getUserData() async {
    // Remplacez ceci par le code pour obtenir les données utilisateur
    // Exemple de données utilisateur simulées
    return UserModel(
      username: 'Hector KOMBOU',
      email: 'djoukwekombou9@gmail.com',
      telephone: '+237753934267', // Format international complet
      password: 'password123',
      profileType: '0',
    );
  }

  Future<void> updateRecord(UserModel user) async {
    // Ajoutez ici le code pour mettre à jour les enregistrements utilisateur
    // Exemple : envoyer les données à une API ou les enregistrer dans une base de données
    print('Mise à jour des données utilisateur: ${user.username}');
    print('Nouveau numéro de téléphone: ${user.telephone}');

    // Simuler une opération asynchrone
    await Future.delayed(Duration(seconds: 1));
  }
}

// Page de profil avec bouton de déconnexion
class ProfilePage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E5E5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profil",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Photo de profil
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/profil.jpg'),
              ),
              const SizedBox(height: 20),

              // Informations utilisateur
              Text(
                'Hector KOMBOU',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'djoukwekombou9@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              // Menu du profil
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Modifier le profil
                    ListTile(
                      leading: Icon(Icons.edit, color: Colors.blue),
                      title: Text('Modifier le profil'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => EditProfile());
                      },
                    ),
                    Divider(height: 1),

                    // À propos de l'application
                    ListTile(
                      leading: Icon(Icons.info, color: Colors.green),
                      title: Text('À propos de l\'application'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigation vers la page à propos
                        // Get.to(() => AboutPage());
                      },
                    ),
                    Divider(height: 1),

                    // Utilisateurs bloqués
                    ListTile(
                      leading: Icon(Icons.block, color: Colors.orange),
                      title: Text('Utilisateurs bloqués'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigation vers la page utilisateurs bloqués
                        // Get.to(() => BlockedUsersPage());
                      },
                    ),
                    Divider(height: 1),

                    // Paramètres
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.grey[600]),
                      title: Text('Paramètres'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigation vers la page paramètres
                        Get.to(() => PresentPage());
                      },
                    ),
                    Divider(height: 1),

                    // Déconnexion
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Déconnexion',
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                      onTap: () {
                        _showLogoutDialog(context);
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

  // Dialog de confirmation pour la déconnexion
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer le dialog
                await _performLogout();
              },
            ),
          ],
        );
      },
    );
  }

  // Effectuer la déconnexion
  Future<void> _performLogout() async {
    try {
      // Afficher un indicateur de chargement
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Effectuer la déconnexion
      await controller.logout();

      // Fermer l'indicateur de chargement
      Get.back();

      // Afficher un message de succès
      Get.snackbar(
        'Déconnexion',
        'Vous avez été déconnecté avec succès',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );

      // Rediriger vers la page d'accueil - MODIFIEZ SELON VOTRE PAGE D'ACCUEIL
      // Option 1: Si vous avez une route nommée
      Get.offAllNamed(
        'pages/home_page.dart',
      ); // ou '/home' ou '/accueil' selon vos routes

      // Option 2: Si vous avez une page d'accueil spécifique, remplacez HomePage par le nom de votre page
      // Get.offAll(() => HomePage());

      // Option 3: Si votre page d'accueil s'appelle AccueilPage
      // Get.offAll(() => AccueilPage());
    } catch (e) {
      // Fermer l'indicateur de chargement en cas d'erreur
      if (Get.isDialogOpen!) Get.back();

      // Afficher un message d'erreur
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de la déconnexion: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool showpass = true;
  final _formKey = GlobalKey<FormState>();

  Uint8List? _image;
  String? completePhoneNumber; // Variable pour stocker le numéro complet

  // Contrôleur spécifique pour le champ téléphone
  final TextEditingController phoneController = TextEditingController();

  final SignupController controller = Get.put(SignupController());

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  // Méthode pour extraire le code pays du numéro de téléphone
  String _getCountryCode(String phoneNumber) {
    if (phoneNumber.startsWith('+1')) return 'US';
    if (phoneNumber.startsWith('+33')) return 'FR';
    if (phoneNumber.startsWith('+44')) return 'GB';
    if (phoneNumber.startsWith('+49')) return 'DE';
    if (phoneNumber.startsWith('+39')) return 'IT';
    if (phoneNumber.startsWith('+34')) return 'ES';
    if (phoneNumber.startsWith('+81')) return 'JP';
    if (phoneNumber.startsWith('+86')) return 'CN';
    if (phoneNumber.startsWith('+91')) return 'IN';
    if (phoneNumber.startsWith('+55')) return 'BR';
    if (phoneNumber.startsWith('+7')) return 'RU';
    if (phoneNumber.startsWith('+27')) return 'ZA';
    if (phoneNumber.startsWith('+234')) return 'NG';
    if (phoneNumber.startsWith('+20')) return 'EG';
    if (phoneNumber.startsWith('+237')) return 'CM';
    if (phoneNumber.startsWith('+225')) return 'CI';
    if (phoneNumber.startsWith('+221')) return 'SN';
    if (phoneNumber.startsWith('+223')) return 'ML';
    if (phoneNumber.startsWith('+226')) return 'BF';
    if (phoneNumber.startsWith('+227')) return 'NE';
    if (phoneNumber.startsWith('+228')) return 'TG';
    if (phoneNumber.startsWith('+229')) return 'BJ';
    if (phoneNumber.startsWith('+230')) return 'MU';
    if (phoneNumber.startsWith('+231')) return 'LR';
    if (phoneNumber.startsWith('+232')) return 'SL';
    if (phoneNumber.startsWith('+233')) return 'GH';
    if (phoneNumber.startsWith('+235')) return 'TD';
    if (phoneNumber.startsWith('+236')) return 'CF';
    if (phoneNumber.startsWith('+238')) return 'CV';
    if (phoneNumber.startsWith('+239')) return 'ST';
    if (phoneNumber.startsWith('+240')) return 'GQ';
    if (phoneNumber.startsWith('+241')) return 'GA';
    if (phoneNumber.startsWith('+242')) return 'CG';
    if (phoneNumber.startsWith('+243')) return 'CD';
    if (phoneNumber.startsWith('+244')) return 'AO';
    if (phoneNumber.startsWith('+245')) return 'GW';
    if (phoneNumber.startsWith('+246')) return 'IO';
    if (phoneNumber.startsWith('+248')) return 'SC';
    if (phoneNumber.startsWith('+249')) return 'SD';
    if (phoneNumber.startsWith('+250')) return 'RW';
    if (phoneNumber.startsWith('+251')) return 'ET';
    if (phoneNumber.startsWith('+252')) return 'SO';
    if (phoneNumber.startsWith('+253')) return 'DJ';
    if (phoneNumber.startsWith('+254')) return 'KE';
    if (phoneNumber.startsWith('+255')) return 'TZ';
    if (phoneNumber.startsWith('+256')) return 'UG';
    if (phoneNumber.startsWith('+257')) return 'BI';
    if (phoneNumber.startsWith('+258')) return 'MZ';
    if (phoneNumber.startsWith('+260')) return 'ZM';
    if (phoneNumber.startsWith('+261')) return 'MG';
    if (phoneNumber.startsWith('+262')) return 'RE';
    if (phoneNumber.startsWith('+263')) return 'ZW';
    if (phoneNumber.startsWith('+264')) return 'NA';
    if (phoneNumber.startsWith('+265')) return 'MW';
    if (phoneNumber.startsWith('+266')) return 'LS';
    if (phoneNumber.startsWith('+267')) return 'BW';
    if (phoneNumber.startsWith('+268')) return 'SZ';
    if (phoneNumber.startsWith('+269')) return 'KM';

    // Par défaut, retourner France
    return 'FR';
  }

  // Méthode pour extraire le numéro sans le code pays
  String _getPhoneNumberWithoutCountryCode(
    String fullPhoneNumber,
    String countryCode,
  ) {
    // Map des codes pays vers leurs indicatifs
    Map<String, String> countryDialCodes = {
      'US': '+1',
      'FR': '+33',
      'GB': '+44',
      'DE': '+49',
      'IT': '+39',
      'ES': '+34',
      'JP': '+81',
      'CN': '+86',
      'IN': '+91',
      'BR': '+55',
      'RU': '+7',
      'ZA': '+27',
      'NG': '+234',
      'EG': '+20',
      'CM': '+237',
      'CI': '+225',
      'SN': '+221',
      'ML': '+223',
      'BF': '+226',
      'NE': '+227',
      'TG': '+228',
      'BJ': '+229',
      'MU': '+230',
      'LR': '+231',
      'SL': '+232',
      'GH': '+233',
      'TD': '+235',
      'CF': '+236',
      'CV': '+238',
      'ST': '+239',
      'GQ': '+240',
      'GA': '+241',
      'CG': '+242',
      'CD': '+243',
      'AO': '+244',
      'GW': '+245',
      'IO': '+246',
      'SC': '+248',
      'SD': '+249',
      'RW': '+250',
      'ET': '+251',
      'SO': '+252',
      'DJ': '+253',
      'KE': '+254',
      'TZ': '+255',
      'UG': '+256',
      'BI': '+257',
      'MZ': '+258',
      'ZM': '+260',
      'MG': '+261',
      'RE': '+262',
      'ZW': '+263',
      'NA': '+264',
      'MW': '+265',
      'LS': '+266',
      'BW': '+267',
      'SZ': '+268',
      'KM': '+269',
    };

    String dialCode = countryDialCodes[countryCode] ?? '+33';

    if (fullPhoneNumber.startsWith(dialCode)) {
      return fullPhoneNumber.substring(dialCode.length);
    }

    // Si le numéro ne commence pas par l'indicatif, retourner le numéro sans le premier caractère '+'
    if (fullPhoneNumber.startsWith('+')) {
      // Extraire tout sauf les premiers chiffres de l'indicatif
      String digitsOnly = fullPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      if (countryCode == 'US' || countryCode == 'RU') {
        return digitsOnly.length > 1 ? digitsOnly.substring(1) : digitsOnly;
      } else if (countryCode == 'FR') {
        return digitsOnly.length > 2 ? digitsOnly.substring(2) : digitsOnly;
      } else if (countryCode == 'CM') {
        return digitsOnly.length > 3 ? digitsOnly.substring(3) : digitsOnly;
      } else {
        // Pour les autres pays, essayer de deviner
        return digitsOnly.length > 3 ? digitsOnly.substring(2) : digitsOnly;
      }
    }

    return fullPhoneNumber;
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      return await image.readAsBytes();
    } else {
      throw Exception("No image selected");
    }
  }

  void selectImage() async {
    try {
      Uint8List img = await pickImage(ImageSource.gallery);
      setState(() {
        _image = img;
      });
    } catch (e) {
      // Gérer l'erreur si aucune image n'est sélectionnée
      print('Erreur lors de la sélection de l\'image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE3E5E5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Navigation vers la page de profil utilisateur
              Get.off(() => ProfilePage());
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left_solid,
              color: Colors.black,
              size: 28,
            ),
          ),
          title: const Text(
            "Modifier le Profil",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;

                    final username = TextEditingController(text: user.username);
                    final email = TextEditingController(text: user.email);
                    final password = TextEditingController(text: user.password);
                    String selectedProfileType = user.profileType;

                    // Initialiser le numéro complet
                    completePhoneNumber = user.telephone;

                    // Obtenir le code pays et le numéro sans indicatif
                    String initialCountryCode = _getCountryCode(user.telephone);
                    String phoneWithoutCountryCode =
                        _getPhoneNumberWithoutCountryCode(
                          user.telephone,
                          initialCountryCode,
                        );

                    return Column(
                      children: [
                        // Section photo de profil
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                  radius: 75,
                                  backgroundImage: MemoryImage(_image!),
                                )
                                : CircleAvatar(
                                  radius: 75,
                                  backgroundImage: AssetImage(
                                    'assets/images/profil.jpg',
                                  ),
                                ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  onPressed: selectImage,
                                  color: Colors.white,
                                  icon: Icon(Icons.add_a_photo, size: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        // Formulaire
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Champ nom d'utilisateur
                              TextFormField(
                                controller: username,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: 'Nom d\'utilisateur',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un nom d\'utilisateur';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Champ email
                              TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un email';
                                  }
                                  if (!GetUtils.isEmail(value)) {
                                    return 'Veuillez entrer un email valide';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              Container(
                                child: IntlPhoneField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    labelText: 'Téléphone',
                                    hintText: 'Ex: 753934267',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 16,
                                    ),
                                  ),
                                  // Configuration pour assurer l'affichage
                                  languageCode: "fr",
                                  initialCountryCode:
                                      'CM', // Cameroun par défaut
                                  showCountryFlag: true,
                                  showDropdownIcon: true,
                                  dropdownIcon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey.shade600,
                                  ),
                                  searchText: "Rechercher un pays",
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,

                                  // Configuration critique pour l'affichage
                                  autovalidateMode: AutovalidateMode.disabled,
                                  disableLengthCheck: true,

                                  // Style du texte pour s'assurer qu'il est visible
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                  ),

                                  onChanged: (phone) {
                                    completePhoneNumber = phone.completeNumber;
                                    print('═══ PHONE DEBUG ═══');
                                    print(
                                      'Pays: ${phone.countryISOCode} (${phone.countryCode})',
                                    );
                                    print('Numéro saisi: "${phone.number}"');
                                    print(
                                      'Numéro complet: "$completePhoneNumber"',
                                    );
                                    print(
                                      'Controller text: "${phoneController.text}"',
                                    );
                                    print('═══════════════════');
                                  },

                                  onCountryChanged: (country) {
                                    print(
                                      'Pays changé: ${country.name} (${country.code})',
                                    );
                                  },

                                  validator: (phone) {
                                    if (phone == null ||
                                        phone.number.trim().isEmpty) {
                                      return 'Veuillez entrer un numéro de téléphone';
                                    }
                                    String digitsOnly = phone.number.replaceAll(
                                      RegExp(r'[^\d]'),
                                      '',
                                    );
                                    if (digitsOnly.length < 6) {
                                      return 'Le numéro doit contenir au moins 6 chiffres';
                                    }
                                    if (digitsOnly.length > 15) {
                                      return 'Le numéro ne peut pas dépasser 15 chiffres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Bouton de modification
                              MaterialButton(
                                minWidth: 170,
                                height: 50,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Vérifier si un numéro de téléphone a été saisi
                                    if (completePhoneNumber == null ||
                                        completePhoneNumber!.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.orange,
                                          content: const Text(
                                            "Veuillez saisir un numéro de téléphone",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    final userData = UserModel(
                                      username: username.text.trim(),
                                      telephone:
                                          completePhoneNumber!, // Utiliser le numéro complet mis à jour
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                      profileType: selectedProfileType.trim(),
                                    );

                                    try {
                                      await controller.updateRecord(userData);

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: const Text(
                                            "Les données utilisateurs ont été mises à jour",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );

                                      // Rediriger vers la page de profil après la mise à jour
                                      await Future.delayed(
                                        Duration(seconds: 1),
                                      );
                                      Get.back(); // ou Get.offNamed('/profile');
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Erreur lors de la mise à jour: $e",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                color: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text(
                                  "Modifier",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(
                      child: Text("Une erreur s'est produite"),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Page d'accueil (HomePage) - Remplacez ceci par votre vraie page d'accueil
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accueil'), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Bienvenue sur la page d\'accueil !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ProfilePage());
              },
              child: Text('Aller au Profil'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Vente',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Déjà sur la page d'accueil
              break;
            case 1:
              // Navigation vers chatbot
              // Get.to(() => ChatbotPage());
              break;
            case 2:
              // Navigation vers vente
              // Get.to(() => VentePage());
              break;
            case 3:
              Get.to(() => ProfilePage());
              break;
          }
        },
      ),
    );
  }
}
