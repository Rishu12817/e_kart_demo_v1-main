import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../../../widgets/round_button.dart';
import '../../btmNav/bottom_nav.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // for firebase auth
  bool loading = false;
  //
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
//
  bool _passwordVisible = false; 

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    // firebase checking for the authentication
    if (_formField.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });

        loading = true;
        Timer(Duration(seconds: 2), () {
          // loading = true;
          const snackBar = SnackBar(
          content: Text("Welcome to Ekart"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottonNavigator()));
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
      // const snackBar = SnackBar(
      //   content: Text("Submitting form"),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Timer(Duration(seconds: 2), () {
      //   Navigator.pop(context);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Sign Up',
            style: TextStyle(
                // color: Color.fromARGB(255, 0, 0, 0),
                // fontSize: 30,

                ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formField,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                          return "Please enter correct name";
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter correct Password';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible, // Use _passwordVisible here
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 50, right: 10, left: 10),
              child: RoundBotton(
                title: "Create Account",
                loading: loading,
                onTap: () {
                  login();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
