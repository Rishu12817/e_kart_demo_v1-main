import 'dart:async';
import 'package:e_kart_demo_v1/ui/search_screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import '../auth/login/login_screen.dart';
import '../kart/ekartScreen.dart';
import '../model/api_services.dart';
import '../model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Product> products = [];
  bool loading = true;
  int limit = 10;
  ScrollController scrollController = ScrollController();
  DateTime prev_backpress = DateTime.now();

  Future<void> fetchProducts() async {
    try {
      ModelProduct modelProduct = await ApiService.fetchData(limit);
      setState(() {
        products = modelProduct.products;
        loading = false;
        limit += 20;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    handleScroll();
    fetchProducts();
  }

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
                Navigator.pop(context);
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

  void handleScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchProducts();
      }
    });
  }

  Future<void> handleTap(int index) async {
    Product selectedProduct = products[index];

    print('Item ${selectedProduct.id} tapped');
    print('NAME        : ${selectedProduct.title} ');
    print('Price       : Rs.${selectedProduct.price} ');

    DatabaseReference ref = FirebaseDatabase.instance.ref(
      "eKart/users/${_auth.currentUser!.uid}/cartItems/${selectedProduct.id}",
    );

    // Used the snapshot getter to get DataSnapshot from DatabaseEvent
    DataSnapshot snapshot = await ref.once().then((event) => event.snapshot);

    if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> item = snapshot.value as Map<dynamic, dynamic>;
      if (item['Quantity'] is int) {
        int currentQuantity = item['Quantity'] as int;
        if (currentQuantity < 10) {
          await ref.update({"Quantity": currentQuantity + 1});
          final snake = SnackBar(
              content: Text("Item added to your cart"),
              duration: Duration(milliseconds: 150));
          ScaffoldMessenger.of(context).showSnackBar(snake);
        } else {
          final snake = SnackBar(
              content: Text("You can't add more than 10 items."),
              duration: Duration(milliseconds: 150));
          ScaffoldMessenger.of(context).showSnackBar(snake);
        }
      } else {
        await ref.set({
          "User": _auth.currentUser!.email,
          "id": selectedProduct.id,
          "Name": selectedProduct.title,
          "Price": (selectedProduct.price*82).toString(),
          "Thumbnail": selectedProduct.thumbnail,
          "Quantity": 1,
        });
        final snake = SnackBar(
            content: Text("Item added to your cart"),
            duration: Duration(milliseconds: 150));
        ScaffoldMessenger.of(context).showSnackBar(snake);
      }
    } else {
      await ref.set({
        "User": _auth.currentUser!.email,
        "id": selectedProduct.id,
        "Name": selectedProduct.title,
        "Price": (selectedProduct.price*82).toString(),
        "Thumbnail": selectedProduct.thumbnail,
        "Quantity": 1,
      });
      final snake = SnackBar(
          content: Text("Item added to your cart"),
          duration: Duration(milliseconds: 150));
      ScaffoldMessenger.of(context).showSnackBar(snake);
    }

    print("Item added to cart.");
  }

  Future<void> handleTapGesture(int index) async {
    Product selectedProduct = products[index];
    print('Item ${selectedProduct.id} tapped');
    print('NAME        : ${selectedProduct.title}');
    print('Price       : Rs.${(selectedProduct.price*82)}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(prev_backpress);
        prev_backpress = DateTime.now();
        final cantExit = timeGap >= Duration(seconds: 2);
        if (cantExit) {
          final snake = SnackBar(
              content: Text("Press back button again to exit"),
              duration: Duration(seconds: 2));
          ScaffoldMessenger.of(context).showSnackBar(snake);
          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ekart : Home '),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                showLogoutDialog();
              },
            ),
          ],
        ),
        body: Visibility(
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
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  handleTap(index);
                  // handleTapGesture(index); // Uncomment this line if you want to use handleTapGesture instead of handleTap
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
                            products[index].thumbnail,
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
                              products[index].title,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Item Number: ${products[index].id}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '\₹${(products[index].price*82).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                handleTap(index);
                              },
                              child: Text('Add to Cart'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
