
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/round_button.dart';
import '../../../btmNav/bottom_nav.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String VerificationId;
  const VerifyCodeScreen({super.key, required this.VerificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;

  final TextEditingController verificationCodeController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text('Enter the verification code'),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: verificationCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '6 digit code',
                  hintText: "6 digit code",
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
                  title: "Verify",
                  onTap: () 
                  async 
                  {
                    setState(() {
                      loading = true;
                    });
                    final credential = PhoneAuthProvider.credential(
                        verificationId: widget.VerificationId,
                        smsCode: verificationCodeController.text.toString());
                    try {
                      await auth.signInWithCredential(credential);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottonNavigator()));
                    } catch (e) {
                      print(e);
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(e.toString());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
