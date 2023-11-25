import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Order History')),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print("Order is tapped");
              print("------------------------");
              print("Order placed on 2023-07-${index + 1}");
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text('Order #${index + 1}'),
                subtitle: Text('Order placed on 2023-07-${index + 1}'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          );
        },
      ),
    );
  }
}
