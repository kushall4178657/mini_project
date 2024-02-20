import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/icon.png'),
              ),
              Text(
                'HouseFix is an App that aims to provide household services to Users as well as a platform to Unorganised Workers where they can find work.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'This app is under Development feel free to provide you\'re valuable feedbacks/suggestions',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
