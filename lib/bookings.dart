// import 'dart:async';
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class BookingsPage extends StatefulWidget {
//   @override
//   State<BookingsPage> createState() => _BookingsPageState();
// }

// class _BookingsPageState extends State<BookingsPage> {
//   final List<String> _hours = <String>[
//     '08:00',
//     '08:30',
//     '09:00',
//     '09:30',
//     '10:00',
//     '10:30',
//     '11:00',
//     '11:30',
//     '12:00',
//     '12:30',
//     '13:00',
//     '13:30',
//     '14:00',
//     '14:30',
//     '15:00',
//     '15:30',
//     '16:00',
//     '16:30',
//     '17:00',
//     '17:30',
//     '18:00',
//     '18:30',
//     '19:00',
//     '19:30',
//     '20:00',
//     '20:30',
//     '21:00',
//     '21:30',
//     '22:00',
//     '22:30',
//     '23:00',
//     '23:30',
//   ];

//   // String formatServiceData(dynamic serviceData) {
//   //   if (serviceData == null || serviceData.isEmpty) return '';

//   //   try {
//   //     // Parse the JSON string into a List<Map<String, dynamic>>
//   //     List<Map<String, dynamic>> serviceList =
//   //         (jsonDecode(serviceData) as List<dynamic>)
//   //             .cast<Map<String, dynamic>>();

//   //     String formattedService = 'Cleaning Service:';
//   //     serviceList.forEach((service) {
//   //       if (service['name'] != null &&
//   //           service['sqft'] != null &&
//   //           service['count'] != null) {
//   //         formattedService +=
//   //             '${service['name']}, Sqft: ${service['sqft']}, Count: ${service['count']}';
//   //       }
//   //     });
//   //     return formattedService;
//   //   } catch (e) {
//   //     print('Error parsing JSON: $e');
//   //     return '';
//   //   }
//   // }

//   // String formatCookServiceData(dynamic serviceData) {
//   //   if (serviceData == null || serviceData.isEmpty) return '';

//   //   try {
//   //     // Parse the JSON string into a List<Map<String, dynamic>>
//   //     List<Map<String, dynamic>> serviceList =
//   //         (jsonDecode(serviceData) as List<dynamic>)
//   //             .cast<Map<String, dynamic>>();

//   //     String formattedService = 'Cooking Service:';
//   //     serviceList.forEach((service) {
//   //       if (service['name'] != null && service['personCount'] != null) {
//   //         formattedService +=
//   //             '${service['name']}, Person Count: ${service['personCount'].round()}';
//   //       }
//   //     });
//   //     return formattedService;
//   //   } catch (e) {
//   //     print('Error parsing JSON: $e');
//   //     return '';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2, // Number of tabs
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.pink.shade400,
//             title: Text(
//               'Bookings',
//               style: TextStyle(color: Colors.white),
//             ),
//             bottom: TabBar(
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.black,
//               indicatorColor: Colors.black,
//               tabs: [
//                 Tab(
//                   text: 'Upcoming',
//                 ),
//                 Tab(text: 'Past'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               _buildOrdersList(true), // true for upcoming orders
//               _buildOrdersList(false), // false for past orders
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrdersList(bool upcoming) {
//     // Function to fetch orders based on upcoming status
//     Stream<QuerySnapshot> getOrdersStream() {
//       return FirebaseFirestore.instance
//           .collection('Users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('Orders')
//           .snapshots();
//     }

//     return StreamBuilder<QuerySnapshot>(
//       stream: getOrdersStream(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }
//         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Text('No ${upcoming ? 'upcoming' : 'past'} orders found'),
//           );
//         }
//         // If orders are available, display them
//         return ListView(
//           children: snapshot.data!.docs.map((order) {
//             Map<String, dynamic> data = order.data() as Map<String, dynamic>;
//             String orderDateTimeString = data['datetime'];

//             // Manually parse the date and time string
//             List<String> dateTimeParts = orderDateTimeString.split(' ');
//             List<String> dateParts = dateTimeParts[0].split('-');
//             List<String> timeParts = dateTimeParts[1].split(':');

//             int year = int.parse(dateParts[2]);
//             int month = int.parse(dateParts[1]);
//             int day = int.parse(dateParts[0]);
//             int hour = int.parse(timeParts[0]);
//             int minute = int.parse(timeParts[1]);

//             DateTime orderDateTime = DateTime(year, month, day, hour, minute);
//             bool isUpcoming = orderDateTime.isAfter(DateTime.now());

//             // Extracting time from the orderDateTime
//             String orderTime = '${orderDateTime.hour}:${orderDateTime.minute}';

//             // Checking if the order is upcoming or past and matches the time slot
//             if (isUpcoming == upcoming && _hours.contains(orderTime)) {
//               // String orderservice = '';
//               // if (data['Cleaning Service'] != null &&
//               //     data['Cleaning Service'] != '') {
//               //   orderservice += formatServiceData(data['Cleaning Service']);
//               // }
//               // if (data['Carpenter Service'] != null &&
//               //     data['Carpenter Service'] != '-') {
//               //   orderservice +=
//               //       'Carpenter Service:' + data['Carpenter Service'];
//               // }
//               // if (data['Plumbing Service'] != null &&
//               //     data['Plumbing Service'] != '-') {
//               //   orderservice += 'Plumbing Service:' + data['Plumbing Service'];
//               // }
//               // if (data['Electrician Service'] != null &&
//               //     data['Electrician Service'] != '-') {
//               //   orderservice +=
//               //       'Electrician Service:' + data['Electrician Service'];
//               // }
//               // if (data['Cooking Service'] != null &&
//               //     data['Cooking Service'] != '') {
//               //   orderservice += formatCookServiceData(data['Cooking Service']);
//               // }
//               // if (data['Painting Service'] != null &&
//               //     data['Painting Service'] != '--') {
//               //   orderservice += 'Painting Service:' + data['Painting Service'];
//               // }
//               return Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.circular(10.0)),
//                 padding: EdgeInsets.all(10.0),
//                 margin: EdgeInsets.all(8),
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text('Name:${data['name']}'),
//                         Spacer(),
//                         Text('Phone:${data['phone number']}')
//                       ],
//                     ),
//                     Text('Payment: ${data['payment']}'),
//                     Text('Date: ${data['datetime']}'),
//                     Text('Service Charges: ${data['totalVistingcharge']}'),
//                     Text('Address: ${data['Address']}'),
//                     Text('Service Type: ${data['servicetype']}'),
//                     Text('Cleaning Service:${data['Cleaning Service']}'),
//                     Text('Cooking Service:${data['Cooking Service']}'),
//                     Text('Painting Service:${data['Painting Service']}'),
//                     Text('Electrician Service:${data['Electrician Service']}'),
//                     Text('Plumber Service:${data['Plumber Service']}'),
//                     Text('Carpenter Service:${data['Carpenter Service']}'),
//                     Text('Extra Services:${data['extraservice']}'),
//                     Text('Order Status:${data['orderstatus']}'),
//                     // Text('${extraser}'),
//                   ],
//                 ),
//               );
//             } else {
//               // Return an empty container if the order does not match the current view
//               return Container();
//             }
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class BookingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.pink.shade400,
//           title: Text(
//             'Bookings',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: _buildOrdersList(),
//       ),
//     );
//   }

//   Widget _buildOrdersList() {
//     // Function to fetch all orders
//     Stream<QuerySnapshot> getOrdersStream() {
//       return FirebaseFirestore.instance
//           .collection('Users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('Orders')
//           .snapshots();
//     }

//     return StreamBuilder<QuerySnapshot>(
//       stream: getOrdersStream(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }
//         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Text('No orders found'),
//           );
//         }
//         // If orders are available, display them
//         return ListView(
//           children: snapshot.data!.docs.map((order) {
//             Map<String, dynamic> data = order.data() as Map<String, dynamic>;

//             return Container(
//               decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(10.0)),
//               padding: EdgeInsets.all(10.0),
//               margin: EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text('Name: ${data['name']}'),
//                       Spacer(),
//                       Text('Phone: ${data['phone number']}')
//                     ],
//                   ),
//                   Text('Payment: ${data['payment']}'),
//                   Text('Date: ${data['datetime']}'),
//                   Text('Service Charges: ${data['totalVistingcharge']}'),
//                   Text('Address: ${data['Address']}'),
//                   Text('Service Type: ${data['servicetype']}'),
//                   Text('Cleaning Service: ${data['Cleaning Service']}'),
//                   Text('Cooking Service: ${data['Cooking Service']}'),
//                   Text('Painting Service: ${data['Painting Service']}'),
//                   Text('Electrician Service: ${data['Electrician Service']}'),
//                   Text('Plumber Service: ${data['Plumber Service']}'),
//                   Text('Carpenter Service: ${data['Carpenter Service']}'),
//                   Text('Extra Services: ${data['extraservice']}'),
//                   Text('Order Status: ${data['orderstatus']}'),
//                 ],
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade400,
          title: Text(
            'Bookings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildOrdersList(),
      ),
    );
  }

  Widget _buildOrdersList() {
    // Function to fetch all orders sorted by date
    Stream<QuerySnapshot> getOrdersStream() {
      return FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Orders')
          .orderBy('datetime',
              descending: true) // Sorting by date in descending order
          .snapshots();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: getOrdersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No orders found'),
          );
        }
        // If orders are available, display them
        return ListView(
          children: snapshot.data!.docs.map((order) {
            Map<String, dynamic> data = order.data() as Map<String, dynamic>;

            return Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Name: ${data['name']}'),
                      Spacer(),
                      Text('Phone: ${data['phone number']}')
                    ],
                  ),
                  Text('Payment: ${data['payment']}'),
                  Text('Date: ${data['datetime']}'),
                  Text('Service Charges: ${data['totalVistingcharge']}'),
                  Text('Address: ${data['Address']}'),
                  Text('Service Type: ${data['servicetype']}'),
                  Text('Cleaning Service: ${data['Cleaning Service']}'),
                  Text('Cooking Service: ${data['Cooking Service']}'),
                  Text('Painting Service: ${data['Painting Service']}'),
                  Text('Electrician Service: ${data['Electrician Service']}'),
                  Text('Plumber Service: ${data['Plumber Service']}'),
                  Text('Carpenter Service: ${data['Carpenter Service']}'),
                  Text('Extra Services: ${data['extraservice']}'),
                  Text('Order Status: ${data['orderstatus']}'),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
