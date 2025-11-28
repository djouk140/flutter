import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Pay_page(),
    );
  }
}

class Pay_page extends StatefulWidget {
  const Pay_page({super.key});

  @override
  State<Pay_page> createState() => _PayPageState();
}

class _PayPageState extends State<Pay_page> {
  final List<Map<String, String>> _products = [
    {
      'image': 'assets/images/image2.jpg',
      'name': 'Oranges douces',
      'city': 'Paris',
      'id': '001',
      'price': '200 £',
    },
    {
      'image': 'assets/images/image3.jpg',
      'name': 'Récoltes du café',
      'city': 'Marseille',
      'id': '002',
      'price': '210 £',
    },
    {
      'image': 'assets/images/image4.jpg',
      'name': "Arachides de l'ouest",
      'city': 'Amiens',
      'id': '003',
      'price': '84 £',
    },
    {
      'image': 'assets/images/image5.jpg',
      'name': 'Bananes et Plantains',
      'city': 'Toulons',
      'id': '004',
      'price': '50 £',
    },
    {
      'image': 'assets/images/image6.jpg',
      'name': 'Papayes',
      'city': 'Bordeaux',
      'id': '005',
      'price': '8000 FCFA',
    },
    {
      'image': 'assets/images/image7.webp',
      'name': 'pastèques juteuses',
      'city': 'lyon',
      'id': '006',
      'price': '90 £',
    },
    {
      'image': 'assets/images/image8.webp',
      'name': 'cacao ',
      'city': 'Paris',
      'id': '007',
      'price': '120 £',
    },
    {
      'image': 'assets/images/image9.jpg',
      'name': 'Ananas sucré',
      'city': 'Montpellier',
      'id': '008',
      'price': '51 £',
    },
    {
      'image': 'assets/images/image10.png',
      'name': "Avocats ",
      'city': 'Auxerre',
      'id': '009',
      'price': '80 £',
    },
    {
      'image': 'assets/images/image11.jpg',
      'name': 'Mandarine du centre',
      'city': 'Dijon',
      'id': '010',
      'price': '100 £',
    },
    {
      'image': 'assets/images/image12.jpg',
      'name': "Ignames",
      'city': 'Paris',
      'id': '011',
      'price': '12.000 FCFA',
    },
    {
      'image': 'assets/images/image13.jpg',
      'name': 'Manioc',
      'city': 'Nice',
      'id': '012',
      'price': '180 £',
    },
    {
      'image': 'assets/images/image14.jpg',
      'name': "Mangues",
      'city': 'champigny',
      'id': '013',
      'price': '12 £',
    },
    {
      'image': 'assets/images/image15.jpg',
      'name': "Citron ",
      'city': 'saint Etienne',
      'id': '014',
      'price': '70 £',
    },
    {
      'image': 'assets/images/image16.jpg',
      'name': "Canne à sucre",
      'city': 'lille',
      'id': '015',
      'price': '90 £',
    },
    {
      'image': 'assets/images/image17.jpg',
      'name': 'Tournesols chics',
      'city': 'tour',
      'id': '016',
      'price': '50 £',
    },
    {
      'image': 'assets/images/image18.jpg',
      'name': 'Haricots Verts',
      'city': 'Paris',
      'id': '017',
      'price': '50 £',
    },
    {
      'image': 'assets/images/image19.jpg',
      'name': 'Mais',
      'city': 'Toulons',
      'id': '018',
      'price': '15 £',
    },
    {
      'image': 'assets/images/image20.jpg',
      'name': 'HEVEA',
      'city': 'Lyon',
      'id': '019',
      'price': '80 £',
    },
    {
      'image': 'assets/images/image21.jpg',
      'name': 'Patate douce',
      'city': 'Marseille',
      'id': '020',
      'price': '170 £',
    },
    {
      'image': 'assets/images/image22.jpg',
      'name': 'Céreales',
      'city': 'Auxerre',
      'id': '021',
      'price': '500 £',
    },
    {
      'image': 'assets/images/image23.jpg',
      'name': 'Céreles noirs & Blancs',
      'city': 'Verneuil',
      'id': '022',
      'price': '250 £',
    },
    {
      'image': 'assets/images/image24.jpg',
      'name': 'Agrumes',
      'city': 'Poissy',
      'id': '023',
      'price': '150 £',
    },
    {
      'image': 'assets/images/image25.jpg',
      'name': 'Fruits de la Passion',
      'city': 'Montreuil',
      'id': '024',
      'price': '850 £',
    },
    {
      'image': 'assets/images/image26.jpg',
      'name': 'Cérises',
      'city': 'Paris',
      'id': '025',
      'price': '180 £',
    },
    {
      'image': 'assets/images/image27.jpg',
      'name': 'Goyaves',
      'city': 'Caen',
      'id': '026',
      'price': '140 £',
    },
    // Ajoutez plus de produits ici...
  ];

  void _showProductDetails(BuildContext context, Map<String, String> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Détails du Produit'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom: ${product['name']}'),
              Text('Ville: ${product['city']}'),
              Text('Numéro d\'identification: ${product['id']}'),
              Text('Dernier prix acceptable: ${product['price']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes Produits',
          style: TextStyle(fontSize: 34, color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showProductDetails(context, _products[index]),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    _products[index]['image']!,
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _products[index]['name']!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
