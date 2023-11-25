// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../auth/login/login_screen.dart';

// void main() {
//   runApp(HomeScreen());
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Item> items = [
// Item(
//   name: 'Apple',
//   number: 1,
//   price: 10,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,apple',
// ),
// Item(
//   name: 'Mango',
//   number: 2,
//   price: 20,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,mango',
// ),
// Item(
//   name: 'Banana',
//   number: 3,
//   price: 30,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,banana',
// ),
// Item(
//   name: 'Orange',
//   number: 4,
//   price: 40,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,orange',
// ),
// Item(
//   name: 'Grapes',
//   number: 5,
//   price: 50,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,grapes',
// ),
// Item(
//   name: 'Pineapple',
//   number: 6,
//   price: 60,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,pineapple',
// ),
// Item(
//   name: 'Watermelon',
//   number: 7,
//   price: 70,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,watermelon',
// ),
// Item(
//   name: 'Strawberry',
//   number: 8,
//   price: 80,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,strawberry',
// ),
// Item(
//   name: 'Kiwi',
//   number: 9,
//   price: 90,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,kiwi',
// ),
// Item(
//   name: 'Peach',
//   number: 10,
//   price: 100,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,peach',
// ),
// Item(
//   name: 'Lemon',
//   number: 11,
//   price: 110,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,lemon',
// ),
// Item(
//   name: 'Pear',
//   number: 12,
//   price: 120,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,pear',
// ),
// Item(
//   name: 'Raspberry',
//   number: 13,
//   price: 130,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,raspberry',
// ),
// Item(
//   name: 'Blackberry',
//   number: 14,
//   price: 140,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,blackberry',
// ),
// Item(
//   name: 'Apricot',
//   number: 15,
//   price: 150,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,apricot',
// ),
// Item(
//   name: 'Mandarin',
//   number: 16,
//   price: 160,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,mandarin',
// ),
// Item(
//   name: 'Coconut',
//   number: 17,
//   price: 170,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,coconut',
// ),
// Item(
//   name: 'Papaya',
//   number: 18,
//   price: 180,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,papaya',
// ),
// Item(
//   name: 'Guava',
//   number: 19,
//   price: 190,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,guava',
// ),
// Item(
//   name: 'Plum',
//   number: 20,
//   price: 200,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,plum',
// ),
// Item(
//   name: 'Cherry',
//   number: 21,
//   price: 210,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,cherry',
// ),
// Item(
//   name: 'Blueberry',
//   number: 22,
//   price: 220,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,blueberry',
// ),
// Item(
//   name: 'Lime',
//   number: 23,
//   price: 230,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,lime',
// ),
// Item(
//   name: 'Cantaloupe',
//   number: 24,
//   price: 240,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,cantaloupe',
// ),
// Item(
//   name: 'Fig',
//   number: 25,
//   price: 250,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,fig',
// ),
// Item(
//   name: 'Passion Fruit',
//   number: 26,
//   price: 260,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,passion-fruit',
// ),
// Item(
//   name: 'Dragon Fruit',
//   number: 27,
//   price: 270,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,dragon-fruit',
// ),
// Item(
//   name: 'Lychee',
//   number: 28,
//   price: 280,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,lychee',
// ),
// Item(
//   name: 'Pomegranate',
//   number: 29,
//   price: 290,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,pomegranate',
// ),
// Item(
//   name: 'Cranberry',
//   number: 30,
//   price: 300,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,cranberry',
// ),
// Item(
//   name: 'Avocado',
//   number: 31,
//   price: 310,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,avocado',
// ),
// Item(
//   name: 'Clementine',
//   number: 32,
//   price: 320,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,clementine',
// ),
// Item(
//   name: 'Tangerine',
//   number: 33,
//   price: 330,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,tangerine',
// ),
// Item(
//   name: 'Honeydew',
//   number: 34,
//   price: 340,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,honeydew',
// ),
// Item(
//   name: 'Nectarine',
//   number: 35,
//   price: 350,
//   imageUrl: 'https://source.unsplash.com/random/1366x768/?fruit,nectSure!',

// ),

//   ];

//   List<Item> filteredItems = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredItems = items;
//   }

//   void filterItems(String query) {
//     setState(() {
//       filteredItems = items
//           .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Home Screen'),
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
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                   mainAxisSpacing: 8.0,
//                   crossAxisSpacing: 8.0,
//                 ),
//                 itemCount: filteredItems.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final item = filteredItems[index];

//                   return GestureDetector(
//                     onTap: () {
//                       // Handle item tap
//                       print('Item ${item.number} tapped');
//                     },
//                     child: Card(
//                       elevation: 2.0,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(4.0),
//                               child: Image.network(
//                                 item.imageUrl,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.name,
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4.0),
//                                 Text(
//                                   'Item Number: ${item.number}',
//                                   style: TextStyle(fontSize: 14.0),
//                                 ),
//                                 SizedBox(height: 4.0),
//                                 Text(
//                                   '\₹ ${item.price.toStringAsFixed(2)}',
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Handle Add to Cart button press
//                                 print('Add to Cart: ${item.name}');
//                               },
//                               child: Text('Add to Cart'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }

// class Item {
//   final name;
//   final int number;
//   final double price;
//   final String imageUrl;

//   Item({
//     required this.name,
//     required this.number,
//     required this.price,
//     required this.imageUrl,
//   });
// }
