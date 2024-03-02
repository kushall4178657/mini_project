import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro/fetchdata.dart';

class Mylogout extends StatefulWidget {
  const Mylogout({super.key});
  @override
  State<Mylogout> createState() => _MylogoutState();
}

class _MylogoutState extends State<Mylogout> {
  var auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                MyWidget(FirebaseAuth.instance.currentUser),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'editprofile');
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  thickness: 0,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.settings),
                  ),
                  title: Text('Settings'),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.chevron_right_rounded),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'settings');
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.library_books_rounded),
                  ),
                  title: Text('My Bookings'),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.chevron_right_rounded),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'bookings');
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.feedback_outlined),
                  ),
                  title: Text('Feedback'),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.chevron_right_rounded),
                  ),
                ),
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.info_outline_rounded),
                  ),
                  title: Text('About Us'),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.chevron_right_rounded),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'aboutus');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
