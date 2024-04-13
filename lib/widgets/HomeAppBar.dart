import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_pro/fetchdata.dart';
import 'package:mini_pro/pages/select_service.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 5, 2, 3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              "Welcome ${MyWidget(FirebaseAuth.instance.currentUser).name}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Spacer(),
          // Container(
          //   //padding: EdgeInsets.only(right: 0),
          //   child: Row(
          //     children: [
          //       IconButton(
          //         onPressed: () {
          //           Navigator.pushNamed(context, 'logout');
          //         },
          //         icon: Icon(
          //           Icons.account_circle_sharp,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
