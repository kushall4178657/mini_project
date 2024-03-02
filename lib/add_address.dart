import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Add/Select Address',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
