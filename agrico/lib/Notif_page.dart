import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notif_page extends StatefulWidget {
  const Notif_page({Key? key}) : super(key: key);

  @override
  State<Notif_page> createState() => _Notif_pageState();
}

class _Notif_pageState extends State<Notif_page> {
  final List<Map<String, String>> _products = [
    {'image': 'assets/images/image2.jpg', 'description': 'Oranges douces'},
    {'image': 'assets/images/image3.jpg', 'description': 'Récoltes du café'},
    {
      'image': 'assets/images/image4.jpg',
      'description': "Arachides de l'ouest",
    },
    {
      'image': 'assets/images/image5.jpg',
      'description': 'Bananes et Plantains',
    },
    {'image': 'assets/images/image6.jpg', 'description': 'Papayes solos'},
    {'image': 'assets/images/image7.webp', 'description': 'Pastèques juteux'},
    {'image': 'assets/images/image8.webp', 'description': 'Cacao de Kribi'},
    {'image': 'assets/images/image9.jpg', 'description': 'Ananas sucré'},
    {'image': 'assets/images/image10.png', 'description': "Avocats de l'ouest"},
    {'image': 'assets/images/image11.jpg', 'description': 'Bonne Mandarine'},
    {'image': 'assets/images/image12.jpg', 'description': 'Igname'},
    {'image': 'assets/images/image13.jpg', 'description': 'Manioc'},
    {'image': 'assets/images/image14.jpg', 'description': 'Mangues juteuses'},
    {'image': 'assets/images/image15.jpg', 'description': 'Citrons'},
    {'image': 'assets/images/image16.jpg', 'description': 'Canne à sucré'},
    {'image': 'assets/images/image17.jpg', 'description': 'Tournesol chics'},
    {'image': 'assets/images/image18.jpg', 'description': 'Haricots verts'},
    {'image': 'assets/images/image19.jpg', 'description': 'Mais'},
    {'image': 'assets/images/image20.jpg', 'description': 'HEVEA'},
    {'image': 'assets/images/image21.jpg', 'description': 'Patates douces'},
    {'image': 'assets/images/image22.jpg', 'description': 'Céréales'},
    {
      'image': 'assets/images/image23.jpg',
      'description': 'Céréales noir & blancs',
    },
    {'image': 'assets/images/image24.jpg', 'description': 'Agrumes'},
    {'image': 'assets/images/image25.jpg', 'description': 'Fruits de Passion'},
    {'image': 'assets/images/image26.jpg', 'description': 'Cérises'},
    {'image': 'assets/images/image27.jpg', 'description': 'Goyaves'},
  ];

  List<Map<String, String>> _filteredProducts = [];
  double _balance = 0.0;
  bool _showBalance = true;

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
    _balance = 0.0; // 🔄 Initialisation à 0.00 £
  }

  void _searchProduct(String query) {
    setState(() {
      _filteredProducts =
          _products
              .where(
                (product) => product['description']!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  void _showPaymentForm(BuildContext context, Map<String, String> product) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Commander pour ${product['description']}'),
            content: PaymentForm(product: product),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        titleTextStyle: const TextStyle(color: Colors.white),
        toolbarHeight: 60,
        title: const Text('Produits', style: TextStyle(fontSize: 18)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Solde du compte",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _showBalance
                          ? '${_balance.toStringAsFixed(2)} £'
                          : '*****',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showBalance = !_showBalance;
                        });
                      },
                      child: Text(
                        _showBalance ? 'masquer' : 'afficher',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchProduct,
              decoration: const InputDecoration(
                labelText: 'Rechercher un produit',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: const EdgeInsets.all(8),
              children:
                  _filteredProducts.map((product) {
                    return GestureDetector(
                      onTap: () {
                        _showPaymentForm(context, product);
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  product['image']!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product['description']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentForm extends StatefulWidget {
  final Map<String, String> product;

  const PaymentForm({Key? key, required this.product}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMode = 'Orange Money';
  String _phoneNumber = '';
  String _initialPrice = '5';
  String _finalPrice = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('commandes').add({
        'product': widget.product['description'],
        'paymentMode': _paymentMode,
        'phoneNumber': _phoneNumber,
        'initialPrice': _initialPrice,
        'finalPrice': _finalPrice,
        'createdAt': DateTime.now(),
      });

      // Ferme la modale
      Navigator.of(context).pop();

      // ✅ Notification stylisée
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Commande validée et prise en compte !',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _paymentMode,
              onChanged: (value) {
                setState(() {
                  _paymentMode = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Orange Money',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/image29.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text('Orange Money'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'PayPal',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/paypal.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text('PayPal'),
                    ],
                  ),
                ),
              ],
              decoration: const InputDecoration(labelText: 'Mode de paiement'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Numéro de téléphone',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre numéro de téléphone';
                }
                return null;
              },
              onSaved: (value) => _phoneNumber = value!,
            ),
            TextFormField(
              initialValue: '$_initialPrice £',
              decoration: const InputDecoration(labelText: 'Prix initial'),
              enabled: false,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Prix final',
                suffixText: '£',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le prix final';
                }
                return null;
              },
              onSaved: (value) => _finalPrice = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
