import 'package:flutter/material.dart';
import '../firebase_services/splash_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/shoppingbag.png')),
              ),
              Column(
                children: [
                  Shimmer.fromColors(
                    child: Text(
                      'Welcome to E-Kart',
                      style: TextStyle(
                        fontFamily: 'Aquire',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                    ),
                    baseColor: const Color.fromARGB(255, 227, 15, 0),
                    highlightColor: Color.fromARGB(255, 212, 212, 212),
                  ),
                  Shimmer.fromColors(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SpinKitDoubleBounce(
                          color: Color.fromARGB(255, 227, 15, 0)),
                    ),
                    baseColor: const Color.fromARGB(255, 227, 15, 0),
                    highlightColor: Color.fromARGB(255, 234, 234, 234),
                  ),
                ],
              ),

              // SpinKitDoubleBounce(color: Color.fromARGB(255, 227, 15, 0))
            ],
          ),
        ),
      ),
    );
    // }  @override
    // Widget build(BuildContext context) {
    //   return const Scaffold(
    //     body: SafeArea(
    //       child: Center(
    //         child: Text("Splash Screen",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           fontSize: 30.0,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         ),
    //       ),
    //     ),
    //   );
  }
}
