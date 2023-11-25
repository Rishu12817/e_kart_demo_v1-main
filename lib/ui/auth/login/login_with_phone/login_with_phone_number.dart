import 'package:e_kart_demo_v1/ui/auth/login/login_with_phone/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  // loading state for login
  bool loading = false;
  // phone number controller for login with phone no.
  final TextEditingController phoneNumberController = TextEditingController();

  // Firebase auth instance for login with phone number.
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Text('Phone Number Verification'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (valuee) {
                    if (valuee![0] != '+') {
                      return "Please enter '+' sign at the beginning of your phone no. \nalong with your country code. eg: +91";
                    }
                    if (valuee.isEmpty ||
                        !RegExp(r'^\+91[0-9]{10}$').hasMatch(valuee)) {
                      return "Please enter correct phone no.";
                    } else {
                      return null;
                    }
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: "ex: +91987543210  (no spaces)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: RoundBotton(
                    title: "Send OTP",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        auth.verifyPhoneNumber(
                            phoneNumber: phoneNumberController.text,
                            verificationCompleted: (_) {
                              setState(() {
                                loading = false;
                              });
                              // print("\n\n\n"+phoneNumberController.text+"\n\n\n");
                            },
                            verificationFailed: (e) {
                              Utils().toastMessage(e.toString());
                            },
                            codeSent: (String verificationId, int? token) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyCodeScreen(
                                            VerificationId: verificationId,
                                          )));
                              setState(() {
                                loading = false;
                              });
                            },
                            codeAutoRetrievalTimeout: (e) {
                              Utils().toastMessage(e.toString());
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
