import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pro/order_summary.dart';
import 'package:mini_pro/pages/date_time.dart';

class SelectedRoom {
  final String name;
  final double sqft;
  final int count;
  final int price;

  SelectedRoom(this.name, this.sqft, this.count, this.price);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sqft': sqft,
      'count': count,
    };
  }
}

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  static List<SelectedRoom> final_rooms = [];
  static String json = '';
  static int price = 0;

  static void resetFinalService() {
    OrderSummary.selectedRooms = [];
    CleaningPage.json = '';
    CleaningPage.price = 0;
  }

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  List<Map<String, dynamic>> _rooms = [
    {
      'name': 'Living Room',
      'iconUrl': 'https://img.icons8.com/officel/2x/living-room.png',
      'color': Colors.red,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
      'price': 50,
    },
    {
      'name': 'Bedroom',
      'iconUrl': 'https://img.icons8.com/fluency/2x/bedroom.png',
      'color': Colors.orange,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
      'price': 50,
    },
    {
      'name': 'Bathroom',
      'iconUrl': 'https://img.icons8.com/color/2x/bath.png',
      'color': Colors.blue,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
      'price': 50,
    },
    {
      'name': 'Kitchen',
      'iconUrl': 'https://img.icons8.com/dusk/2x/kitchen.png',
      'color': Colors.purple,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
      'price': 50,
    },
    {
      'name': 'Office',
      'iconUrl': 'https://img.icons8.com/color/2x/office.png',
      'color': Colors.green,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
      'price': 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _rooms.any((room) => room['selected'])
            ? FloatingActionButton(
                onPressed: () {
                  // Navigate to next page
                  List<SelectedRoom> selectedRooms = [];
                  for (var room in _rooms) {
                    if (room['selected']) {
                      selectedRooms.add(
                        SelectedRoom(room['name'], room['sqft'], room['count'],
                            room['price']),
                      );
                    }
                  }
                  OrderSummary.selectedRooms = selectedRooms;
                  CleaningPage.price = selectedRooms.length * 50;
                  CleaningPage.json = jsonEncode(
                      selectedRooms.map((room) => room.toJson()).toList());

                  // print(CleaningPage.final_rooms[0].name);
                  // print(selectedRooms[0].name);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DateAndTime(),
                  //   ),
                  // );
                  Get.to(() => DateAndTime());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_rooms.where((room) => room['selected']).length}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
                backgroundColor: Colors.blue,
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: Text(
                    'Where do you want to be cleaned?',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _rooms.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildRoomWidget(_rooms[index], index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomWidget(Map<String, dynamic> room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rooms[index]['selected'] = !_rooms[index]['selected'];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: room['selected']
              ? room['color'].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.network(
                      room['iconUrl'],
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      room['name'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                room['selected']
                    ? Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            room['selected']
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "How many ${room['name']}s?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.purple,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (_rooms[index]['count'] < 5) {
                                  _rooms[index]['count']++;
                                }
                              });
                            },
                          ),
                          Text(
                            'Count: ${room['count']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            color: Colors.purple,
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (_rooms[index]['count'] > 1) {
                                  _rooms[index]['count']--;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Slider(
                        activeColor: Colors.red,
                        inactiveColor: Colors.pink.shade50,
                        label: 'Select ${room['name']} Sq.ft',
                        value: room['sqft'],
                        onChanged: (value) {
                          setState(() {
                            _rooms[index]['sqft'] = value.roundToDouble();
                          });
                        },
                        max: 5000,
                        min: 50,
                      ),
                      Text(
                        'Selected ${room['name']} Sqft is: ${room['sqft'].toInt()}',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
