import 'package:e_kart_demo_v1/ui/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../accountscreen/account_screen.dart';
import '../home_screen/home_screen.dart';
// import '../home_screen/old_HomeScreens/post_screen.dart';

class BottonNavigator extends StatefulWidget {
  const BottonNavigator({super.key});

  @override
  State<BottonNavigator> createState() => _BottonNavigatorState();
}

class _BottonNavigatorState extends State<BottonNavigator> {
  //
  DateTime prev_backpress = DateTime.now();
  //
  int _index = 0;

  final Screen = [
    HomeScreen(),
    OrderScreen(),
    AccountScreen(),
    // PostScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(prev_backpress);

        print("$timeGap");

        prev_backpress = DateTime.now();
        final cantExit = timeGap >= Duration(seconds: 2);

        if (cantExit) {
          // show snakbar
          final snake = SnackBar(
              content: Text("Press back button again to exit"),
              duration: Duration(seconds: 2));
          ScaffoldMessenger.of(context).showSnackBar(snake);
          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
        //
        // SystemNavigator.pop();
        // return true;
      },
      child: Scaffold(
        body: Screen[_index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "orders"),
            BottomNavigationBarItem(icon: Icon(Icons.manage_accounts_outlined), label: "Account"),
            // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Kart"),
          ],
        ),
      ),
    );
  }
}
