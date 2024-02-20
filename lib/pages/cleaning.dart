// import 'package:mini_pro/animation/FadeAnimation.dart';
// import 'package:mini_pro/pages/date_time.dart';
// import 'package:flutter/material.dart';

// class CleaningPage extends StatefulWidget {
//   const CleaningPage({Key? key}) : super(key: key);

//   @override
//   _CleaningPageState createState() => _CleaningPageState();
// }

// class _CleaningPageState extends State<CleaningPage> {
//   // Rooms to clean
//   double bathroomsqft = 50.0;
//   double bedroomsqft = 100.0;
//   List<dynamic> _rooms = [
//     [
//       'Living Room',
//       'https://img.icons8.com/officel/2x/living-room.png',
//       Colors.red,
//       1
//     ],
//     [
//       'Bedroom',
//       'https://img.icons8.com/fluency/2x/bedroom.png',
//       Colors.orange,
//       1
//     ],
//     ['Bathroom', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
//     ['Kitchen', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
//     ['Office', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
//   ];

//   List<int> _selectedRooms = [];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           floatingActionButton: _selectedRooms.length > 0
//               ? FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => DateAndTime()),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '${_selectedRooms.length}',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(width: 2),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         size: 18,
//                       ),
//                     ],
//                   ),
//                   backgroundColor: Colors.blue,
//                 )
//               : null,
//           body: NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverToBoxAdapter(
//                   child: FadeAnimation(
//                     1,
//                     Padding(
//                       padding:
//                           EdgeInsets.only(top: 80.0, right: 20.0, left: 20.0),
//                       child: Text(
//                         'Where do you want to be cleaned?',
//                         style: TextStyle(
//                           fontSize: 35,
//                           color: Colors.grey.shade900,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ];
//             },
//             body: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: _rooms.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return FadeAnimation(
//                         (1.2 + index) / 4, room(_rooms[index], index));
//                   }),
//             ),
//           )),
//     );
//   }

//   room(List room, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (_selectedRooms.contains(index))
//             _selectedRooms.remove(index);
//           else
//             _selectedRooms.add(index);
//         });
//       },
//       child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//           margin: EdgeInsets.only(bottom: 20.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: _selectedRooms.contains(index)
//                 ? room[2].shade50.withOpacity(0.5)
//                 : Colors.grey.shade100,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Row(
//                     children: [
//                       Image.network(
//                         room[1],
//                         width: 35,
//                         height: 35,
//                       ),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       Text(
//                         room[0],
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   _selectedRooms.contains(index)
//                       ? Container(
//                           padding: EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                             color: Colors.greenAccent.shade100.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Icon(
//                             Icons.check,
//                             color: Colors.green,
//                             size: 20,
//                           ))
//                       : SizedBox()
//                 ],
//               ),
//               (_selectedRooms.contains(index) && room[3] >= 1)
//                   ? Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Text(
//                             "How many ${room[0]}s?",
//                             style: TextStyle(fontSize: 15),
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           Container(
//                             height: 45,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 4,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       room[3] = index + 1;
//                                     });
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.only(right: 10.0),
//                                     padding: EdgeInsets.all(10.0),
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       color: room[3] == index + 1
//                                           ? room[2].withOpacity(0.5)
//                                           : room[2].shade200.withOpacity(0.5),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         (index + 1).toString(),
//                                         style: TextStyle(
//                                             fontSize: 22, color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Approx Sq.Ft of ${room[0]}'),
//                           Slider(
//                             label: 'Select Bedroom Sq.ft',
//                             value: bedroomsqft,
//                             onChanged: (value) {
//                               setState(() {
//                                 bedroomsqft = value;
//                                 print(value);
//                               });
//                             },
//                             max: 5000,
//                             min: 100,
//                           ),
//                           Text(
//                               'Selected ${room[0]} Sqft is:${bedroomsqft.toInt()}')
//                         ],
//                       ),
//                     )
//                   : SizedBox(),
//             ],
//           )),
//     );
//   }
// }

// import 'package:mini_pro/animation/FadeAnimation.dart';
// import 'package:mini_pro/pages/date_time.dart';
// import 'package:flutter/material.dart';

// class CleaningPage extends StatefulWidget {
//   const CleaningPage({Key? key}) : super(key: key);

//   @override
//   _CleaningPageState createState() => _CleaningPageState();
// }

// class _CleaningPageState extends State<CleaningPage> {
//   // Rooms to clean
//   List<Map<String, dynamic>> _rooms = [
//     {
//       'name': 'Living Room',
//       'iconUrl': 'https://img.icons8.com/officel/2x/living-room.png',
//       'color': Colors.red,
//       'selected': false,
//       'sqft': 50.0,
//     },
//     {
//       'name': 'Bedroom',
//       'iconUrl': 'https://img.icons8.com/fluency/2x/bedroom.png',
//       'color': Colors.orange,
//       'selected': false,
//       'sqft': 100.0,
//     },
//     {
//       'name': 'Bathroom',
//       'iconUrl': 'https://img.icons8.com/color/2x/bath.png',
//       'color': Colors.blue,
//       'selected': false,
//       'sqft': 50.0,
//     },
//     {
//       'name': 'Kitchen',
//       'iconUrl': 'https://img.icons8.com/dusk/2x/kitchen.png',
//       'color': Colors.purple,
//       'selected': false,
//       'sqft': 100.0,
//     },
//     {
//       'name': 'Office',
//       'iconUrl': 'https://img.icons8.com/color/2x/office.png',
//       'color': Colors.green,
//       'selected': false,
//       'sqft': 100.0,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         floatingActionButton: _rooms.any((room) => room['selected'])
//             ? FloatingActionButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => DateAndTime()),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${_rooms.where((room) => room['selected']).length}',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: 2),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 18,
//                     ),
//                   ],
//                 ),
//                 backgroundColor: Colors.blue,
//               )
//             : null,
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverToBoxAdapter(
//                 child: FadeAnimation(
//                   1,
//                   Padding(
//                     padding:
//                         EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
//                     child: Text(
//                       'Where do you want to be cleaned?',
//                       style: TextStyle(
//                         fontSize: 35,
//                         color: Colors.grey.shade900,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ];
//           },
//           body: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _rooms.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return FadeAnimation(
//                   (1.2 + index) / 4,
//                   room(_rooms[index], index),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget room(Map<String, dynamic> room, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _rooms[index]['selected'] = !_rooms[index]['selected'];
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//         margin: EdgeInsets.only(bottom: 20.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: room['selected']
//               ? room['color'].shade50.withOpacity(0.5)
//               : Colors.grey.shade100,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Image.network(
//                       room['iconUrl'],
//                       width: 35,
//                       height: 35,
//                     ),
//                     SizedBox(
//                       width: 10.0,
//                     ),
//                     Text(
//                       room['name'],
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 room['selected']
//                     ? Container(
//                         padding: EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                           color: Colors.greenAccent.shade100.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Icon(
//                           Icons.check,
//                           color: Colors.green,
//                           size: 20,
//                         ),
//                       )
//                     : SizedBox()
//               ],
//             ),
//             room['selected']
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 20.0),
//                       Text(
//                         "How many ${room['name']}s?",
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       SizedBox(height: 10.0),
//                       Slider(
//                         label: 'Select ${room['name']} Sq.ft',
//                         value: room['sqft'],
//                         onChanged: (value) {
//                           setState(() {
//                             _rooms[index]['sqft'] = value;
//                           });
//                         },
//                         max: 5000,
//                         min: 50,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                           'Selected ${room['name']} Sqft is: ${room['sqft'].toInt()}')
//                     ],
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mini_pro/pages/date_time.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

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
    },
    {
      'name': 'Bedroom',
      'iconUrl': 'https://img.icons8.com/fluency/2x/bedroom.png',
      'color': Colors.orange,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
    },
    {
      'name': 'Bathroom',
      'iconUrl': 'https://img.icons8.com/color/2x/bath.png',
      'color': Colors.blue,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
    },
    {
      'name': 'Kitchen',
      'iconUrl': 'https://img.icons8.com/dusk/2x/kitchen.png',
      'color': Colors.purple,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
    },
    {
      'name': 'Office',
      'iconUrl': 'https://img.icons8.com/color/2x/office.png',
      'color': Colors.green,
      'selected': false,
      'sqft': 100.0,
      'count': 1,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DateAndTime()),
                  );
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
                                _rooms[index]['count']++;
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
                            _rooms[index]['sqft'] = value;
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
