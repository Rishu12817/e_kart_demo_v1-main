// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../auth/login/login_screen.dart';
// // import '../auth/login_screen.dart';

// void main() {
//   runApp(HomeScreen());
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Product> items = [];
//   List<Product> filteredItems = [];

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }
// // making an HTTP GET request to retrieve the product data
//   void fetchProducts() async {
//     final response = await http.get(Uri.parse('https://dummyjson.com/products'));
//     if (response.statusCode == 200) {
//       // when the call to the server is successful, 
//       //
//       //parsing the JSON
//       final jsonBody = json.decode(response.body);
//       // then fetch the products from the JSON
//       final List<dynamic> productsData = jsonBody['products'];
//       // then fetch the product from the list of products
//       final List<Product> fetchedItems = productsData.map((productData) {
//         // convert the JSON to a Product object
//         return Product.fromJson(productData);
//         // return the product
//       }).toList();

//       // then create a new product object from the list of fetched items and add it to the list of products data and add the product to the list of products data and add the product to the list of products data and add the product to the list of products data.

//       setState(() {
//         // The filterItems function is likely defined within a stateful widget, as it uses setState to update the state of the widget.
//         items = fetchedItems;
//         filteredItems = fetchedItems;
//       });
//     }
//   }


// // Within the setState function, the filteredItems list is updated by filtering the items list based on the query parameter.
//   void filterItems(String query) {

//     // By calling setState, the state of the widget is updated, triggering a rebuild of the UI. The UI will reflect the changes made to the filteredItems list.
//     setState(() {
//     // The where method is used on the items list to filter out the items that meet a certain condition. In this case, the condition is defined by the anonymous function (item) => item.title.toLowerCase().contains(query.toLowerCase()).
//       filteredItems = items
//           .where(
//             (item) => item.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//           // This anonymous function is applied to each item in the items list. It checks if the lowercase version of the item's title contains the lowercase version of the query. The contains method returns true if the query is found in the item's title and false otherwise.
//           //
//           // The resulting filtered items are converted into a new list using the toList method.
//     });
//   }

// // so basically the filterItems function is responsible for filtering the items list based on a given query and updating the filteredItems list. 
// //
// ////This allows for dynamic filtering and updating of the UI based on user input.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout_outlined),
//             onPressed: () {
//               _auth.signOut().then((value) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: filterItems,
//               // The onChanged property is set to filterItems. It refers to a function that will be called whenever the user changes the text in the TextField. The function filterItems is likely defined elsewhere in the code and is responsible for performing some action based on the user's input.
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.7,
//                 mainAxisSpacing: 8.0,
//                 crossAxisSpacing: 8.0,
//               ),
//               itemCount: filteredItems.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // The itemBuilder function is called for each item in the filteredItems list to build the corresponding widget in the grid view. The index parameter represents the index of the current item being built.
//                 final item = filteredItems[index];

//                 return GestureDetector(
//                   // The GestureDetector widget is used to wrap each item widget and provide a callback function onTap that is triggered when the item is tapped. In this case, the callback prints a message indicating which item was tapped.
//                   onTap: () {
//                     // Handle item tap
//                     print('Item ${item.id} tapped');
//                     print('NAME        : ${item.title} ');
//                     print('Category    : ${item.category} ');
//                     print('Price       : Rs.${item.price} ');
//                     print('Description:: ${item.description} ');
//                   },
//                   child: Card(
//                     elevation: 2.0,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(4.0),
//                             child: Image.network(
//                               item.thumbnail,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.title,
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 4.0),
//                               Text(
//                                 'Item Number: ${item.id}',
//                                 style: TextStyle(fontSize: 14.0),
//                               ),
//                               SizedBox(height: 4.0),
//                               Text(
//                                 '\₹ ${item.price.toStringAsFixed(2)}',
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Handle Add to Cart button press
//                               print('Add to Cart: ${item.title}');
//                             },
//                             child: Text('Add to Cart'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // When making an HTTP GET request, the API response provides more information about the product than just the ID, title, and price.
// class Product {
//   final int id;
//   final String title;
//   final String description;
//   final double price;
//   final double discountPercentage;
//   final double rating;
//   final int stock;
//   final String brand;
//   final String category;
//   final String thumbnail;
//   final List<String> images;

// // The Product class represents the complete structure of a product from the API response, allowing for future flexibility and expansion.
//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.discountPercentage,
//     required this.rating,
//     required this.stock,
//     required this.brand,
//     required this.category,
//     required this.thumbnail,
//     required this.images,
//   });

//   // The fromJson factory constructor creates a Product object from the JSON data, assuming all properties are present.
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(

//       // Utilizing all properties in the class allows for easier adaptation and potential functionality expansion in the future.
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       price: json['price'].toDouble(),
//       discountPercentage: json['discountPercentage'].toDouble(),
//       rating: json['rating'].toDouble(),
//       stock: json['stock'],
//       brand: json['brand'],
//       category: json['category'],
//       thumbnail: json['thumbnail'],
//       images: List<String>.from(json['images']),
//     );
//   }
// }
// // Having the complete Product class and constructor enables easy access to additional information if needed.