import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_pro/pages/select_service.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 5, 2, 3),
      child: Row(
        children: [
          Icon(
            Icons.location_pin,
            size: 25,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              "Nandanvan \n"
              "Nagpur",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Container(
            //padding: EdgeInsets.only(right: 0),
            child: Row(
              children: [
                //Padding(padding: EdgeInsets.only(right: 10)),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.search_rounded,
                //     color: Colors.pink,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'logout');
                  },
                  icon: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
