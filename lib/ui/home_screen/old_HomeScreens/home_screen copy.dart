// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../auth/login/login_screen.dart';
// import '../kart/cart_item.dart';
// import '../kart/ekartScreen.dart';
// import '../model/api_services.dart';
// import '../model/model.dart';
// // import '../model/cart_item.dart';
// // import '../screens/cart_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   List<Product> products = [];
//   ScrollController scrollController = ScrollController();
//   bool loading = true;
//   int limit = 10;
//   List<CartItem> cartItems = [];

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

//   void handleScroll() {
//     scrollController.addListener(() async {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.position.pixels) {
//         print("object is called ");
//         fetchProducts();
//       }
//     });
//   }

//   void handleTap(int index) {
//     Product selectedProduct = products[index];
//     print('Item ${selectedProduct.id} tapped');
//     print('NAME        : ${selectedProduct.title} ');
//     print('Price       : Rs.${selectedProduct.price} ');

//     // Create a CartItem object and add it to the cartItems list
//     CartItem cartItem = CartItem(product: selectedProduct, quantity: 1);
//     setState(() {
//       cartItems.add(cartItem);
//     });

//     // Navigate to the CartScreen and pass the cartItems list
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
//     );
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
//                   handleTap(index);
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
