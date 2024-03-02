import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text('No Bookings Made Yet!'),
      ),
    ));
  }
}
