import 'dart:async';
import 'package:e_kart_demo_v1/ui/auth/signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/utils.dart';
import '../../../widgets/round_button.dart';
import '../../btmNav/bottom_nav.dart';
import 'login_with_phone/login_with_phone_number.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // for firebase auth
  bool loading = false;

  final _formField = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 
  bool _passwordVisible = false; 

    
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    // for firebase auth we need to set the password for the current user and then we can login the user with the new password
    setState(() {
      // loading here means that the user is already logged in and we can login the user with the new password and then we can login the user with the new password and then we can login the
      loading = true;
    });

      // _auth is the firebase auth instance we are using to login the user with the new password and then we can login the user with the new password and then we can login the user.

      //Sign in with Email and Password to Firebase Auth  and then login the user with the new password and then we can login the user with the new password and then we can login
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
          // for the toast handleing
          // Utils will return the value as a string and the toast will show the value as a string and we need to convert the string to a string and return the value as a string and
      Utils().toastMessage(value.user!.email.toString());

      // Timer for the toast message to disappear when the user is not logged in and the user is not logged in
      Timer(Duration(seconds: 2), () {
        // ScaffoldMessenger will send a message to the snackbar when the user taps
        const snackBar = SnackBar(
          content: Text("Welcome to Ekart"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  BottonNavigator()));
      });
      setState(() {
        loading = false;
      });loading = true;
    }).onError((error, stackTrace) {
      // for the toast handleing
      Utils().toastMessage(error.toString());
      debugPrint(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // here is the widget that will be used to display the loading indicator when loading is true and the loading indicator is hidden when loading is false
    return WillPopScope(
      // WillPopScope is used to prevent the back button from popping the screen.
      onWillPop: () async {
        // this is the widget that will be used to display the loading indicator when loading is true and the loading indicator is hidden when loading is false.
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                  // color: Color.fromARGB(255, 0, 0, 0),
                  // fontSize: 30,
                  ),
            ),
          ),
          // automaticallyImplyLeading will make the back button visible when the user clicks on the back button and the back button is not visible when the user clicks on the back button and the back button is not visible.
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
                        // validator here is used to check if the email is valid or not and if it is not then the error message will be displayed
                        validator: (value) {
                          // RegExp is used to check if the email is valid or not
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value)) {
                            return "Please enter correct name";
                          } else {
                            // return null if the email is valid
                            return null;  
                            
                          }
                        },

                        
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Email",
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
                  title: "Log In",
                  loading: loading,
                  onTap: () {
                    // this is the function that will be called when the user taps on the button
                    // _formField is clicked and the form is validated
                    if (_formField.currentState!.validate()) {
                      // Firebase auth
                      login();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),

                // InkWell is used here to make the text blue when the user taps on it
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginWithPhoneNumber()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text(
                        "Login with Phone Number",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
