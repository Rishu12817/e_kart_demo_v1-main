import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/login/login_screen.dart';
import '../kart/cart_item.dart';
import '../model/api_services.dart';
import '../model/model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  //
    DateTime prev_backpress = DateTime.now();
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  List<Product> products = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int limit = 100;
  List<CartItem> cartItems = [];

  String searchText = '';

  Future<void> fetchProducts() async {
    try {
      ModelProduct modelProduct = await ApiService.fetchData(limit);
      setState(() {
        products = modelProduct.products;
        loading = false;
        // limit += 20;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // handleScroll();
    fetchProducts();
  }

  // void handleScroll() {
  //   scrollController.addListener(() async {
  //     if (scrollController.position.maxScrollExtent ==
  //         scrollController.position.pixels) {
  //       print("object is called ");
  //       fetchProducts();
  //     }
  //   });
  // }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialogboxx
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                });
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void handleTapGesture(int index) {
    Product selectedProduct = products[index];
    print('Item ${selectedProduct.id} tapped');
    print('NAME        : ${selectedProduct.title} ');
    print('Price       : Rs.${selectedProduct.price} ');
  }

  @override
  Widget build(BuildContext context) {

    final searchController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(prev_backpress);

        print("$timeGap");

        prev_backpress = DateTime.now();
        final cantExit = timeGap >= Duration(seconds: 2);

        if (cantExit) {
          // show snakbar
          final snake = SnackBar(
              content: Text("Press back button again to exit Search"),
              duration: Duration(seconds: 2));
          ScaffoldMessenger.of(context).showSnackBar(snake);
          return false;
        } else {
          Navigator.pop(context);
          return true;
        }

        //
        // SystemNavigator.pop();
        // return true;
      },
      child: Scaffold(
        appBar: AppBar(
        title: const Text('Ekart : Search'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              showLogoutDialog(); // Show the logout dialog
            },
          ),
        ],
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: (loading == false),
                replacement: const Center(child: CircularProgressIndicator()),
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: products
                      .where((product) =>
                          product.title.toLowerCase().contains(searchText))
                      .length,
                  itemBuilder: (context, index) {
                    final filteredProducts = products
                        .where((product) =>product.title.toLowerCase().contains(searchText)).toList();
                        
                        final product = filteredProducts[index];
                      if(searchController.text.isEmpty) {
                        return GestureDetector(
                      onTap: () {
                        handleTapGesture(index);
                      },
                      child: Card(
                        elevation: 2.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Image.network(
                                  product.thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Item Number: ${product.id}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '\₹${(product.price*82).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                      }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
