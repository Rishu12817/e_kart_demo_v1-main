import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _displayName;

@override
void initState() {
  super.initState();
  // Get the current user
  _user = _auth.currentUser;
  _setDisplayName();
  handleTap(); 
}


  void _setDisplayName() {
    if (_user != null && _user!.email != null) {
      final emailParts = _user!.email!.split('@');
      _displayName = emailParts[0];
    }
  }

  Future<void> handleTap() async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("eKart/users/${_auth.currentUser!.uid}/profile");
    _setDisplayName();
    await ref.set({
      "Email": _auth.currentUser!.email,
      "User": _auth.currentUser!.displayName == "" ? _displayName: _auth.currentUser!.displayName,
      "PhoneNo": _auth.currentUser!.phoneNumber == "" ? 'N/A': _auth.currentUser!.phoneNumber,
      // Use the null-coalescing operator to provide a default value ('N/A') if phoneNumber is null
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Account')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_user != null) ...[
              ListTile(
                title: Text('Name'),
                subtitle: Text(_displayName ?? 'N/A'),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(_user!.email ?? 'N/A'),
              ),
              // ListTile(
              //   title: Text('Anonymity'),
              //   subtitle: Text(_user!.isAnonymous.toString()),
              // ),
              ListTile(
                title: Text('Phone No.'),
                subtitle: Text(
                  _user!.phoneNumber ?? 'N/A', // Use null-coalescing operator here as well
                  style: TextStyle(color: Colors.black87), // Set a different color for the text
                ),
              ),
              ListTile(
                title: Text('UID'),
                subtitle: Text(_user!.uid),
              ),
            ] else ...[
              Text('You are not logged in'),
            ],
            // ElevatedButton(
            //     onPressed: handleTap,
            //     child: Text("Update now"))
          ],
        ),
      ),
    );
  }
}
