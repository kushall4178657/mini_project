import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade600,
          title: Text(
            "Welcome",
            style: TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {},
          currentIndex: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.green.shade600,
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.checklist_rtl_rounded,
                color: Colors.white,
              ),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.wallet_rounded,
                color: Colors.white,
              ),
              label: 'Bill',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
