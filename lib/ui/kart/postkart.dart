// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// class PostKartScreen extends StatefulWidget {
//   const PostKartScreen({super.key});

//   @override
//   State<PostKartScreen> createState() => _PostKartScreenState();
// }

// class _PostKartScreenState extends State<PostKartScreen> { 
  
//   // final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;


//   // final ref = FirebaseDatabase.instance.ref("eKart/products/${_auth.currentUser!.uid}");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("post kart")),
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FirebaseAnimatedList(
//                 query: FirebaseDatabase.instance.ref("eKart/users/${_auth.currentUser!.uid}/cartItems"),
//                 defaultChild: Center(child: Text("Loading...")),
//                 itemBuilder: ((context, snapshot, animation, index) {
//                   return ListTile(
//                     title: Text(snapshot.child("Name").value.toString()),
//                     subtitle:
//                         Text("Rs." + snapshot.child("Price").value.toString()),
//                     leading: Column(
//                       children: [
//                         Text("ID: " + snapshot.child("id").value.toString()),
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(4.0),
//                             child: Image.network(
//                               snapshot.child("Thumbnail").value.toString(),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.add),
//                           onPressed: () {
//                             setState(() {
//                               // cartItem.quantity++;
//                             });
//                           },
//                         ),
//                         // Text('${cartItem.quantity}'),
//                         IconButton(
//                           icon: Icon(Icons.remove),
//                           onPressed: () {
//                             // setState(() {
//                             //   if (cartItem.quantity > 1) {
//                             //     cartItem.quantity--;
//                             //   } else {
//                             //     removeCartItem(index); // Call the method to remove the item
//                             //   }
//                             // });
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             // removeCartItem(index); // Call the method to remove the item
//                           },
//                         ),
//                       ],
//                     ),
//                     // Text("ID: "+snapshot.child("id").value.toString()),
//                   );
//                 })),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class CartScreencopy extends StatefulWidget {
  const CartScreencopy({Key? key}) : super(key: key);

  @override
  State<CartScreencopy> createState() => _CartScreencopyState();
}

class _CartScreencopyState extends State<CartScreencopy> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _cartItemsRef =
      FirebaseDatabase.instance.reference().child("eKart/users");

  // void onAddPressed(String cartItemId) {
  //   _cartItemsRef
  //       .child(_auth.currentUser!.uid)
  //       .child("cartItems")
  //       .child(cartItemId)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       int currentQuantity = snapshot.value["Quantity"] ?? 0;
  //       int newQuantity = currentQuantity + 1;

  //       // Update the quantity in the database
  //       _cartItemsRef
  //           .child(_auth.currentUser!.uid)
  //           .child("cartItems")
  //           .child(cartItemId)
  //           .update({"Quantity": newQuantity});
  //     }
  //   });
  // }

  // void onRemovePressed(String cartItemId) {
  //   _cartItemsRef
  //       .child(_auth.currentUser!.uid)
  //       .child("cartItems")
  //       .child(cartItemId)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       int currentQuantity = snapshot.value["Quantity"] ?? 0;
  //       int newQuantity = currentQuantity - 1;

  //       if (newQuantity >= 0) {
  //         // Update the quantity in the database
  //         _cartItemsRef
  //             .child(_auth.currentUser!.uid)
  //             .child("cartItems")
  //             .child(cartItemId)
  //             .update({"Quantity": newQuantity});
  //       }
  //     }
  //   });
  // }
  //

  // https://stackoverflow.com/questions/52831605/flutter-shared-preferences
  // for reffrences

  void onDeletePressed(String cartItemId) {
    // Remove the item from the cart in the database
    _cartItemsRef
        .child(_auth.currentUser!.uid)
        .child("cartItems")
        .child(cartItemId)
        .remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .ref("eKart/users/${_auth.currentUser!.uid}/cartItems"),
              defaultChild: Center(child: CircularProgressIndicator()),
              itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                final item = snapshot.value as Map<dynamic, dynamic>;
                final cartItemId = snapshot.key as String;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            item["Thumbnail"].toString(),
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item["Name"].toString(),
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text("Rs. ${item["Price"]}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // onAddPressed(cartItemId);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // onRemovePressed(cartItemId);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                onDeletePressed(cartItemId);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
