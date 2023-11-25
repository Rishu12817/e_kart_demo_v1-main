// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import '../auth/login/login_screen.dart';
// // import '../model/api_services.dart';
// import '../model/model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isLoading = false;
//   List<Product> items = [];
//   List<Product> kartItems = [];
//   List<Product> filteredItems = [];

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   void fetchProducts() async {
//     final response =
//         await http.get(Uri.parse('https://dummyjson.com/products'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       final List<dynamic> productsData = jsonBody['products'];
//       final List<Product> fetchedItems = productsData.map((productData) {
//         return Product.fromJson(productData);
//       }).toList();

//       setState(() {
//         items = fetchedItems;
//         filteredItems = fetchedItems;
//         isLoading = true;
//       });
//     }
//   }

//   void filterItems(String query) {
//     setState(() {
//       filteredItems = items
//           .where(
//               (item) => item.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Ekart : Home'),
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout_outlined),
//               onPressed: () {
//                 _auth.signOut().then((value) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 });
//               },
//             ),
//           ],
//         ),

//         // floatingActionButton: Padding(
//         //   padding: const EdgeInsets.all(10.0),
//         //   child: FloatingActionButton(
//         //     child: Icon(Icons.shopping_cart_outlined),
//         //     onPressed: (){
//         //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => KartScreen()));
//         //   }),
//         // ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: filterItems,
//                 decoration: InputDecoration(
//                   labelText: 'Search',
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: 0, right: 0, bottom: 3, left: 0),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Visibility(
//                 // in future will add shimmer effect here
//                 visible: isLoading,
//                 replacement: const Center(child: CircularProgressIndicator()),

//                 child: GridView.builder(
//                   // controller: ,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                     mainAxisSpacing: 8.0,
//                     crossAxisSpacing: 8.0,
//                   ),
//                   itemCount: filteredItems.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final item = filteredItems[index];

//                     return GestureDetector(
//                       onTap: () {
//                         print('Item ${item.id} tapped');
//                         print('NAME        : ${item.title} ');
//                         // print('Category    : ${item.category} ');
//                         print('Price       : Rs.${item.price} ');
//                         // print('Description:: ${item.description} ');

                      
//                         /// function to send item data to the cart
//                       },
//                       child: Card(
//                         elevation: 2.0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(4.0),
//                                 child: Image.network(
//                                   item.thumbnail,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.title,
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                     'Item Number: ${item.id}',
//                                     style: TextStyle(fontSize: 14.0),
//                                   ),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                     '\₹ ${item.price.toStringAsFixed(2)}',
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   print('Add to Cart: ${item.title}');
//                                 },
//                                 child: Text('Add to Cart'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class Product {
// //   final int id;
// //   final String title;
// //   final String description;
// //   final double price;
// //   final double discountPercentage;
// //   final double rating;
// //   final int stock;
// //   final String brand;
// //   final String category;
// //   final String thumbnail;
// //   final List<String> images;

// //   Product({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.price,
// //     required this.discountPercentage,
// //     required this.rating,
// //     required this.stock,
// //     required this.brand,
// //     required this.category,
// //     required this.thumbnail,
// //     required this.images,
// //   });

// //   factory Product.fromJson(Map<String, dynamic> json) {
// //     return Product(
// //       id: json['id'],
// //       title: json['title'],
// //       description: json['description'],
// //       price: json['price'].toDouble(),
// //       discountPercentage: json['discountPercentage'].toDouble(),
// //       rating: json['rating'].toDouble(),
// //       stock: json['stock'],
// //       brand: json['brand'],
// //       category: json['category'],
// //       thumbnail: json['thumbnail'],
// //       images: List<String>.from(json['images']),
// //     );
// //   }
// // }
