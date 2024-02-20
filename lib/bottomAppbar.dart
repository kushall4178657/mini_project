import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro/bookings.dart';
import 'package:mini_pro/logout.dart';
import 'package:mini_pro/pages/cleaning.dart';
// import 'package:mini_pro/pages/HomePage.dart';
import 'package:mini_pro/pages/home.dart';
import 'package:mini_pro/phone.dart';
import 'package:mini_pro/profile_screen.dart';
import 'package:mini_pro/user_worker.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.grey,
          elevation: 20,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.pink,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.library_books_outlined,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.library_books_outlined,
                color: Colors.black,
              ),
              label: 'Bookings',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          HomePageState(),
          Bookings(),
          Mylogout(),
        ][currentPageIndex],
      ),
    );
  }
}
