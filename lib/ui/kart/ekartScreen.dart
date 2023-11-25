import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // search controller
  final searchFilter = TextEditingController();
  //
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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: searchFilter,
              onChanged: (String value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search in cart items",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .ref("eKart/users/${_auth.currentUser!.uid}/cartItems"),
              defaultChild: Center(child: CircularProgressIndicator()),
              itemBuilder: (context, snapshot, animation, index) {
                final item = snapshot.value as Map<dynamic, dynamic>;
                final itemTitle = item["Name"].toString();
                int count = item["Quantity"];
                if (searchFilter.text.isEmpty) {
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
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      if(count <10){
                                      FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"].toString())
                                          .update({
                                            "Quantity" : count+1
                                          });
                                      }
                                      else{
                                        final snake = SnackBar(
                                        content:
                                            Text("You can't add more than 10 items."),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                                      }
                                    },
                                  ),
                                  Text(" $count "),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {

                                      if(count <= 1){
                                        FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"].toString())
                                          .remove();
                                          final snake = SnackBar(
                                        content:
                                            Text("Item removed from your cart"),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                                      }
                                      else{
                                        FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"].toString())
                                          .update({
                                            "Quantity" : count-1
                                          });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton(onPressed: (){
                                FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"].toString())
                                          .remove();
                                          final snake = SnackBar(
                                        content:
                                            Text("Item removed from cart"),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                              }, child: Text("Remove"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else if (itemTitle.toLowerCase().contains(searchFilter.text.toLowerCase())) {
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
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      if(count <10){
                                      FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"])
                                          .update({
                                            "Quantity" : count+1
                                          });
                                      }
                                      else{
                                        final snake = SnackBar(
                                        content:
                                            Text("You can't add more than 10 items."),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                                      }
                                    },
                                  ),
                                  Text(" $count "),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {

                                      if(count <= 1){
                                        FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"])
                                          .remove();
                                          final snake = SnackBar(
                                        content:
                                            Text("Item removed from your cart"),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                                      }
                                      else{
                                        FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"])
                                          .update({
                                            "Quantity" : count-1
                                          });
                                      }


                                      
                                    },
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.delete),
                                  //   onPressed: () {
                                  //     // Call the method to remove the item
                                  //     // Delete a user from the database
                                  //     FirebaseDatabase.instance
                                  //         .ref(
                                  //             "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                  //         .child(item["id"])
                                  //         .remove();
                                  //   },
                                  // ),
                                ],
                              ),
                              ElevatedButton(onPressed: (){
                                FirebaseDatabase.instance
                                          .ref(
                                              "eKart/users/${_auth.currentUser!.uid}/cartItems")
                                          .child(item["id"])
                                          .remove();
                                          final snake = SnackBar(
                                        content:
                                            Text("Item removed from cart"),
                                        duration: Duration(seconds: 1));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snake);
                              }, child: Text("Remove"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
