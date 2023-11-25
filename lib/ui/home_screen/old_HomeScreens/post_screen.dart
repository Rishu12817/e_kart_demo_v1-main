// import 'dart:async';

// import 'package:e_kart_demo_v1/ui/kart/postkart.dart';
// import 'package:e_kart_demo_v1/ui/search_screen/search_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_database/firebase_database.dart';
// import '../../auth/login/login_screen.dart';
// import '../../kart/cart_item.dart';
// import '../../kart/ekartScreen.dart';
// import '../../model/api_services.dart';
// import '../../model/model.dart';

// class PostScreen extends StatefulWidget {
//   const PostScreen({Key? key}) : super(key: key);

//   @override
//   _PostScreenState createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   //
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   //
//   // DatabaseReference ref = FirebaseDatabase.instance.ref();
//   //
//   // DatabaseReference ref = FirebaseDatabase.instance.ref("eKart/products/${id}");

//   // double back button to exit
//   DateTime prev_backpress = DateTime.now();
//   //
//   // firebase
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   List<Product> products = [];
//   bool loading = true;
//   // List<CartItem> cartItems = [];
//   //pagination vars
//   int limit = 10;
//   ScrollController scrollController = ScrollController();

//   Future<void> fetchProducts() async {
//     try {
//       ModelProduct modelProduct = await ApiService.fetchData(limit);
//       setState(() {
//         products = modelProduct.products;
//         loading = false;
//         limit += 20;
//       });
//     } catch (e) {
//       print('Error fetching products: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     handleScroll();
//     fetchProducts();
//   }

//   // logout the user from the application with alerrt boxxx
//   void showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Logout'),
//           content: Text('Are you sure you want to log out?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _auth.signOut().then((value) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 });
//               },
//               child: Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// // control the scroll position
//   void handleScroll() {
//     scrollController.addListener(() async {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.position.pixels) {
//         print("object is called ");
//         fetchProducts();
//       }
//     });
//   }

//   Future<void> handleTap(int index) async {
//     Product selectedProduct = products[index];

//     print('Item ${selectedProduct.id} tapped');
//     print('NAME        : ${selectedProduct.title} ');
//     print('Price       : Rs.${selectedProduct.price} ');

//     //
// DatabaseReference ref = FirebaseDatabase.instance.ref("eKart/users/${_auth.currentUser!.uid}/cartItems/${selectedProduct.id}");

//     //
//         await ref.set({
//       "id": "${selectedProduct.id}",
//       "Name": selectedProduct.title,
//       "Price": "${selectedProduct.price}",
//       "Thumbnail": selectedProduct.thumbnail,
//       // "Quantity": "${quantity}",
//       // "address": {
//       //   "line1": "100 Mountain View"
//       // }
//     });

//     // // Created a CartItem object and add it to the cartItems list
//     // CartItem cartItem = CartItem(product: selectedProduct, quantity: 1);
//     // setState(() {
//     //   cartItems.add(cartItem);
//     // });
//     // //
//     // Timer(Duration(microseconds: 0), () {
//     //   // Navigator.pop(context);
//     //   // Navigate to the CartScreen and pass the cartItems list
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //         builder: (context) => CartScreen(cartItems: cartItems)),
//     //   );
//     // });
//     // Timer(Duration(milliseconds: 10), () {
//     //   Navigator.pop(context);
//     // });
//   }

//   Future<void> handleTapGesture(int index) async {
//     Product selectedProduct = products[index];
//     int quantity = 0;
//     print('Item ${selectedProduct.id} tapped');
//     print('NAME        : ${selectedProduct.title} ');
//     print('Price       : Rs.${selectedProduct.price} ');

//     // DatabaseReference ref = FirebaseDatabase.instance.ref("eKart/products");
//     //
//     // DatabaseReference ref =
//     //     FirebaseDatabase.instance.ref("eKart/products/${selectedProduct.id}");

//     // await ref.set({
//     //   "id": "${selectedProduct.id}",
//     //   "Name": selectedProduct.title,
//     //   "Price": "${selectedProduct.price}",
//     //   "Thumbnail": selectedProduct.thumbnail,
//     //   "Quantity": "${quantity}",
//     //   // "address": {
//     //   //   "line1": "100 Mountain View"
//     //   // }
//     // });
//     // final ref = FirebaseDatabase.instance.ref();

//     // print("nbgfdfghjhgfdfghjhgfdfghjhgf");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final timeGap = DateTime.now().difference(prev_backpress);
//         //
//         // print("$timeGap");
//         //
//         prev_backpress = DateTime.now();
//         final cantExit = timeGap >= Duration(seconds: 2);
//         //
//         if (cantExit) {
//           // show snakbar
//           final snake = SnackBar(
//               content: Text("Press back button again to exit"),
//               duration: Duration(seconds: 2));
//           ScaffoldMessenger.of(context).showSnackBar(snake);
//           return false;
//         } else {
//           SystemNavigator.pop();
//           return true;
//         }
//         //
//         // SystemNavigator.pop();
//         // return true;
//       }, //
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Ekart : data bejna'),
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.shopping_cart),
//               onPressed: () {
//                 // Navigate to the CartScreen and pass the cartItems list
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PostKartScreen()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 // Navigate to the CartScreen and pass the cartItems list
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SearchScreen()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.logout_outlined),
//               onPressed: () {
//                 // to Show the logout dialog
//                 showLogoutDialog();
//               },
//             ),
//           ],
//         ),
//         body: Visibility(
//           visible: (loading == false),
//           replacement: const Center(child: CircularProgressIndicator()),
//           child: GridView.builder(
//             controller: scrollController,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.7,
//               mainAxisSpacing: 8.0,
//               crossAxisSpacing: 8.0,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   // handleTap(index);
//                   handleTapGesture(index);
//                 },
//                 child: Card(
//                   elevation: 2.0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4.0),
//                           child: Image.network(
//                             products[index].thumbnail,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               products[index].title,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(
//                               'Item Number: ${products[index].id}',
//                               style: TextStyle(fontSize: 14.0),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(
//                               '\₹ ${products[index].price.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             handleTap(index);
//                               // HapticFeedback.mediumImpact();
                              
//                           },
//                           child: Text('Add to Cart'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
